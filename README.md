# 🧠 Brain Health Assistant

Brain Health Assistant is a comprehensive Flutter-based mobile application designed to empower users with AI-driven insights into brain health. The app leverages machine learning models to predict stroke risks, detect abnormalities in MRI scans, and provide a personalized AI companion for health-related queries.

## ✨ Key Features

* **Stroke Risk Prediction:** Uses health data (age, hypertension, heart disease, smoking status, glucose levels, BMI) to estimate stroke probability via an XGBoost model.
* **Stroke MRI Detection:** A CNN-based classification model analyzes brain MRI scans to detect signs of stroke.
* **Alzheimer's Prediction:** A Random Forest model assesses Alzheimer's risk based on clinical health factors.
* **Brain Tumor Detection:** A CNN-based classification model analyzes MRI images to detect and classify brain tumors.
* **AI Chatbot:** An interactive companion ("Brain Assistant") that answers questions related to stroke, Alzheimer's, and brain tumors.
* **Personalized Profiles:** Dynamic user profiles with secure authentication and data management.

## 🚀 Tech Stack

* **Frontend:** [Flutter](https://flutter.dev/) (Dart)
* **State Management:** [Flutter Bloc](https://pub.dev/packages/flutter_bloc) (Cubit)
* **Backend & Auth:** [Firebase](https://firebase.google.com/) (Authentication, Cloud Firestore) & [Supabase](https://supabase.com/)
* **Networking:** [Dio](https://pub.dev/packages/dio) & [HTTP](https://pub.dev/packages/http) for API integration
* **UI/Design:** Google Fonts (Poppins, Inter), Custom UI Components, and responsive layouts.

## 📂 Project Structure

```text
lib/
├── featuers/           # Feature-based modules (Auth, Profile)
│   ├── Auth/           # Login and Registration
│   └── profile/        # User profile management with BLoC
├── Models/             # Data models and conversion logic
├── pages/              # UI Screens (Home, ChatBot, Prediction Results)
├── serviece/           # API and Backend service integrations
└── widgets/            # Reusable UI components (Input fields, Buttons)
```

## 🛠️ Getting Started

### Prerequisites

* Flutter SDK (^3.6.0)
* Dart SDK
* Android Studio / VS Code
* A Firebase project configured for the app

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Maryam948/brain-assistant.git
   cd brain-assistant
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Setup Firebase:**
   * Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the respective directories.

4. **Run the application:**
   ```bash
   flutter run
   ```

## 🧠 AI Models Integration

The app communicates with backend APIs to process health data and MRI images using the following models:

| Feature | Model Type |
|---|---|
| Stroke Risk Prediction | XGBoost |
| Stroke MRI Detection | CNN (Image Classification) |
| Alzheimer's Prediction | Random Forest |
| Brain Tumor Detection | CNN (Image Classification) |
| AI Chatbot | Custom AI endpoint for brain disease Q&A |

* **Prediction Service:** Sends normalized health features to the appropriate ML endpoint (XGBoost / Random Forest).
* **Detection Service:** Sends MRI images to CNN-based classification endpoints.
* **Chatbot Service:** Connects to a custom AI endpoint to provide intelligent responses about stroke, Alzheimer's, and brain tumors.

## 📸 Screenshots

| Splash & Onboarding | Home Dashboard | AI ChatBot |
|:---:|:---:|:---:|
| <img width="270" alt="Screenshot 1" src="https://github.com/user-attachments/assets/eb078409-3ee1-4967-a56a-6440a5a09e5d" /> | <img width="270" alt="Screenshot 2" src="https://github.com/user-attachments/assets/1368ada1-09c6-4232-822b-4857b1d0d8f3" /> | _Add screenshot_ |

## 🤝 Contributing

Contributions are welcome! If you'd like to improve the models or the UI, please follow these steps:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

Distributed under the MIT License.

---

*Disclaimer: This app is for informational purposes and should not replace professional medical advice.*

*Disclaimer: This app is for informational purposes and should not replace professional medical advice.*
