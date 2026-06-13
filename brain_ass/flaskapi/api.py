from flask import Flask, request, jsonify
import pickle
import numpy as np
import torch
import torch.nn as nn
from torchvision import transforms
from PIL import Image
from sentence_transformers import SentenceTransformer
import faiss
import json

app = Flask(__name__)

# ══════════════════════════════════════════
# 1️⃣  XGBoost - Stroke Prediction
# ══════════════════════════════════════════
xgb_model = pickle.load(open("D:/stroke/Stroke/Stroke/saved_models/XGBoost_model.pkl", "rb"))

means = np.array([0.323389482, 55.3106167, 0.0842227080, 0.0500192876,
                  0.725086794, 1.97981227, 0.405169088, 118.840907,
                  29.4386413, 1.25871159])
stds  = np.array([0.46776995, 22.10700633, 0.27772152, 0.21798477,
                  0.44647053, 0.97386647, 0.49092474, 55.05860008,
                  6.61193901, 0.96655345])

def scale_features(features):
    return np.round((features - means) / stds, 10)

@app.route('/predict', methods=['POST'])
def predict_stroke():
    try:
        data = request.get_json()
        features_raw = np.array(data["features"], dtype=np.float64).reshape(1, -1)
        features_scaled = scale_features(features_raw)
        proba = float(xgb_model.predict_proba(features_scaled)[0][1])
        return jsonify({"prediction": int(proba >= 0.5), "probability": proba})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# ══════════════════════════════════════════
# 2️⃣  Chatbot - RAG
# ══════════════════════════════════════════
with open("D:/Downloads/dataset.json", "r", encoding="utf-8") as f:
    dataset = json.load(f)

print("Loading embedding model...")
embed_model = SentenceTransformer("paraphrase-multilingual-MiniLM-L12-v2")
texts      = [item["text"] for item in dataset]
embeddings = embed_model.encode(texts).astype("float32")
faiss.normalize_L2(embeddings)
index = faiss.IndexFlatIP(embeddings.shape[1])
index.add(embeddings)
print(f"FAISS index ready with {len(texts)} entries.")

def retrieve(query, k=3):
    q_emb = embed_model.encode([query]).astype("float32")
    faiss.normalize_L2(q_emb)
    _, I = index.search(q_emb, k)
    return [dataset[i] for i in I[0]]

@app.route('/chat', methods=['POST'])
def chat():
    try:
        query = request.json.get("query", "").strip()
        if not query:
            return jsonify({"error": "Query is empty"}), 400
        docs     = retrieve(query)
        answer   = docs[0]["text"] if docs else "Sorry, I couldn't find relevant information."
        diseases = list(set([d.get("disease", "unknown") for d in docs]))
        return jsonify({
            "answer":   answer,
            "context":  "\n".join([d["text"] for d in docs]),
            "sources":  [d["text"] for d in docs],
            "diseases": diseases
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "ok", "entries": len(dataset)})


# ══════════════════════════════════════════
# 3️⃣  TorchScript - Stroke MRI
# ══════════════════════════════════════════
DEVICE = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

stroke_mri_model = torch.jit.load("D:/Downloads/stroke_model_torchscript.pt", map_location=DEVICE)
stroke_mri_model.to(DEVICE)
stroke_mri_model.eval()

stroke_transform = transforms.Compose([
    transforms.Resize((324, 324)),
    transforms.ToTensor(),
    transforms.Normalize([0.5, 0.5, 0.5], [0.5, 0.5, 0.5])
])
stroke_classes = ['Haemorrhagic', 'Ischemic', 'Normal']

@app.route('/predict_stroke_mri', methods=['POST'])
def predict_stroke_mri():
    try:
        if 'file' not in request.files:
            return jsonify({'error': 'No file uploaded'}), 400
        img = Image.open(request.files['file']).convert('RGB')
        tensor = stroke_transform(img).unsqueeze(0).to(DEVICE)
        with torch.no_grad():
            _, pred = torch.max(stroke_mri_model(tensor), dim=1)
        return jsonify({'prediction': stroke_classes[pred[0].item()]})
    except Exception as e:
        import traceback
        traceback.print_exc()  # ← هيطبع الـ error كامل في الـ terminal
        return jsonify({'error': str(e)}), 500

# ══════════════════════════════════════════
# 4️⃣  CNN - Tumor MRI
# ══════════════════════════════════════════
class MRIModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.layer_stack = nn.Sequential(
            nn.Conv2d(3, 32, 3, 1, 1),   nn.ReLU(),
            nn.Conv2d(32, 64, 3, 1, 1),  nn.ReLU(),
            nn.MaxPool2d(2),
            nn.Conv2d(64, 128, 3, 1, 1), nn.ReLU(),
            nn.Conv2d(128, 256, 3, 1, 1),nn.ReLU(),
            nn.MaxPool2d(2),
            nn.Conv2d(256, 512, 3, 1, 1),nn.ReLU(),
            nn.Conv2d(512,1024, 3, 1, 1),nn.ReLU(),
            nn.MaxPool2d(2), nn.MaxPool2d(4),
            nn.Flatten(),
            nn.Linear(50176, 256), nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(256, 2)
        )
    def forward(self, x):
        return self.layer_stack(x)

tumor_model = MRIModel().to(DEVICE)
tumor_model.load_state_dict(torch.load("D:/Downloads/mri_model (2).pth", map_location=DEVICE))
tumor_model.eval()

tumor_transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor()
])
tumor_classes = ['Healthy', 'Tumor']

@app.route('/predict_tumor', methods=['POST'])
def predict_tumor():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400
    img = Image.open(request.files['file']).convert('RGB')
    tensor = tumor_transform(img).unsqueeze(0).to(DEVICE)
    with torch.no_grad():
        probs      = torch.softmax(tumor_model(tensor), dim=1)
        conf, pred = torch.max(probs, 1)
    return jsonify({'prediction': tumor_classes[pred.item()], 'confidence': float(conf.item())})


# ══════════════════════════════════════════
# ▶️  Run
# ══════════════════════════════════════════
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)