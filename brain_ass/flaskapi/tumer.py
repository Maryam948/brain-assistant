import torch
import torch.nn as nn
from torchvision import transforms
from PIL import Image
from flask import Flask, request, jsonify

# =========================
# ⚙️ Setup
# =========================
app = Flask(__name__)

DEVICE = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

# =========================
# 🧠 Model Architecture
# =========================
class MRIModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.layer_stack = nn.Sequential(
            nn.Conv2d(3, 32, 3, 1, 1),
            nn.ReLU(),

            nn.Conv2d(32, 64, 3, 1, 1),
            nn.ReLU(),
            nn.MaxPool2d(2),

            nn.Conv2d(64, 128, 3, 1, 1),
            nn.ReLU(),

            nn.Conv2d(128, 256, 3, 1, 1),
            nn.ReLU(),
            nn.MaxPool2d(2),

            nn.Conv2d(256, 512, 3, 1, 1),
            nn.ReLU(),

            nn.Conv2d(512, 1024, 3, 1, 1),
            nn.ReLU(),

            nn.MaxPool2d(2),

            nn.MaxPool2d(4),

            nn.Flatten(),

            nn.Linear(50176, 256),
            nn.ReLU(),

            nn.Dropout(0.5),

            nn.Linear(256, 2)
        )

    def forward(self, x):
        return self.layer_stack(x)
# =========================
# 🧠 Load Model (IMPORTANT FIX)
# =========================
model = MRIModel().to(DEVICE)
model.load_state_dict(torch.load("D:/Downloads/mri_model (2).pth", map_location=DEVICE))
model.eval()

# =========================
# 🖼️ Transform
# =========================
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor()
])

classes = ['Healthy', 'Tumor']

# =========================
# 🔮 Predict
# =========================
def predict_image(img):
    img = transform(img).unsqueeze(0).to(DEVICE)

    with torch.no_grad():
        outputs = model(img)
        probs = torch.softmax(outputs, dim=1)
        confidence, pred = torch.max(probs, 1)

    return classes[pred.item()], float(confidence.item())

# =========================
# 📡 API
# =========================
@app.route('/predict_tumor', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400

    file = request.files['file']
    img = Image.open(file).convert('RGB')

    label, confidence = predict_image(img)

    return jsonify({
        'prediction': label,
        'confidence': confidence
    })

# =========================
# ▶️ RUN SERVER
# =========================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)