
import torch
from torchvision import transforms
from PIL import Image
from flask import Flask, request, jsonify

DEVICE = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

model = torch.jit.load("D:/Downloads/stroke_model_torchscript.pt", map_location=DEVICE)
model.to(DEVICE)
model.eval()


transform = transforms.Compose([
    transforms.Resize((324,324)),
    transforms.ToTensor(),
    transforms.Normalize([0.5,0.5,0.5], [0.5,0.5,0.5])
])

classes = ['Haemorrhagic', 'Ischemic', 'Normal']


def predict_image(img, model):
    img = transform(img).unsqueeze(0).to(DEVICE)
    with torch.no_grad():
        yb = model(img)
        _, preds = torch.max(yb, dim=1)
    return classes[preds[0].item()]

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400

    file = request.files['file']
    img = Image.open(file).convert('RGB')
    prediction = predict_image(img, model)

    return jsonify({'prediction': prediction})

if __name__ == '__main__':
    
    app.run(debug=True, host='0.0.0.0', port=5000)
