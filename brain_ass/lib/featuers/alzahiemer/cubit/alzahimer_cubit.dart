// features/alzahimar/cubit/alzahimar_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/featuers/alzahiemer/cubit/alzahimer_state.dart';
import 'package:untitled3/serviece/alzahimar.dart';

class AlzahimarCubit extends Cubit<AlzahimarState> {
  AlzahimarCubit() : super(AlzahimarInitial());

  // ── Personal Info (Page 1) ──────────────────────────
  int age = 0;
  String gender = "Male";
  String education = "None";

  // ── Lifestyle (Page 2) ─────────────────────────────
  double bmi = 0;
  String smokingStatus = "No";
  double alcoholConsumption = 0;
  double physicalActivity = 0;
  double sleepQuality = 4;

  // ── Medical History (Page 3) ───────────────────────
  String familyHistory = "No";
  String cardiovascularDisease = "No";
  String diabetes = "No";
  String depression = "No";
  String headInjury = "No";
  String hypertension = "No";
  double systolicBP = 120;
  double diastolicBP = 80;
  double cholesterolHDL = 50;
  double mmse = 15;
  double functionalAssessment = 5;
  double adl = 5;

  // ── Cognitive Symptoms (Page 4) ────────────────────
  String memoryComplaints = "No";
  String behavioralProblems = "No";
  String confusion = "No";
  String disorientation = "No";
  String personalityChanges = "No";
  String difficultyTasks = "No";
  String forgetfulness = "No";

  // ── Encoding ───────────────────────────────────────
  double _yesNo(String v) => v == "Yes" ? 1.0 : 0.0;

  double _education(String v) {
    switch (v) {
      case "None":   return 0;
      case "Low":    return 1;
      case "Medium": return 2;
      case "High":   return 3;
      default:       return 0;
    }
  }

  // ── Build Features ─────────────────────────────────
  List<double> buildFeatures() {
    return [
      age.toDouble(),                    // Age
      _education(education),             // EducationLevel
      bmi,                               // BMI
      _yesNo(smokingStatus),             // Smoking
      alcoholConsumption,                // AlcoholConsumption
      physicalActivity,                  // PhysicalActivity
      sleepQuality,                      // SleepQuality
      _yesNo(familyHistory),             // FamilyHistoryAlzheimers
      _yesNo(cardiovascularDisease),     // CardiovascularDisease
      _yesNo(diabetes),                  // Diabetes
      _yesNo(depression),                // Depression
      _yesNo(headInjury),                // HeadInjury
      _yesNo(hypertension),              // Hypertension
      systolicBP,                        // SystolicBP
      diastolicBP,                       // DiastolicBP
      cholesterolHDL,                    // CholesterolHDL
      mmse,                              // MMSE
      functionalAssessment,              // FunctionalAssessment
      _yesNo(memoryComplaints),          // MemoryComplaints
      _yesNo(behavioralProblems),        // BehavioralProblems
      adl,                               // ADL
      _yesNo(confusion),                 // Confusion
      _yesNo(disorientation),            // Disorientation
      _yesNo(personalityChanges),        // PersonalityChanges
      _yesNo(difficultyTasks),           // DifficultyCompletingTasks
      _yesNo(forgetfulness),             // Forgetfulness
    ];
  }

  // ── Predict ────────────────────────────────────────
  Future<void> predict() async {
    emit(AlzahimarLoading());
    try {
      final features = buildFeatures();
      print("Features sent: $features");

      final result = await ApiService.predict(features);

      if (result != null) {
        emit(AlzahimarSuccess(
          prediction: result["prediction"],
          probability: List<double>.from(result["probability"]),
        ));
      } else {
        emit(AlzahimarError("Failed to connect to server."));
      }
    } catch (e) {
      emit(AlzahimarError(e.toString()));
    }
  }

  void reset() => emit(AlzahimarInitial());
}