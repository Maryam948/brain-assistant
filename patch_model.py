import joblib
import warnings
warnings.filterwarnings('ignore')
model = joblib.load('D:/brain/models/model(1).pkl')
joblib.dump(model, 'D:/brain/models/model_patched.pkl')
print('Done!')
