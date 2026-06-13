from flask import Flask, request, jsonify
import joblib
import pandas as pd

app = Flask(__name__)

model = joblib.load("D:/brain/models/model_patched.pkl")

COLUMNS = [
    'Age', 'EducationLevel', 'BMI', 'Smoking', 'AlcoholConsumption',
    'PhysicalActivity', 'SleepQuality', 'FamilyHistoryAlzheimers',
    'CardiovascularDisease', 'Diabetes', 'Depression', 'HeadInjury',
    'Hypertension', 'SystolicBP', 'DiastolicBP', 'CholesterolHDL',
    'MMSE', 'FunctionalAssessment', 'MemoryComplaints', 'BehavioralProblems',
    'ADL', 'Confusion', 'Disorientation', 'PersonalityChanges',
    'DifficultyCompletingTasks', 'Forgetfulness'
]

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.json
        features = data['features']

        df = pd.DataFrame([features], columns=COLUMNS)
        df['Cluster'] = 0

        prediction = model.predict(df)[0]
        probability = model.predict_proba(df)[0].tolist()

        return jsonify({
            "prediction": int(prediction),
            "probability": probability
        })

    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)