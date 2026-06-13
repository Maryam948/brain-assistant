// shard_data_alzahimer.dart

class SharedData {
  // ── Page 1: Personal Information ───────────────────
  static int? age;
  static String? gender;       // "Male" | "Female"
  static String? education;    // "None" | "Low" | "Medium" | "High"

  // ── Page 2: Lifestyle ───────────────────────────────
  static double? bmi;
  static String? smokingStatus;       // "Yes" | "No"
  static double? alcoholConsumption;  // 0.0 – 20.0
  static double? physicalActivity;    // 0.0 – 10.0
  static double? sleepQuality;        // 4.0 – 10.0

  // ── Page 3: Medical History + Clinical Measurements ─
  static String? familyHistory;            // "Yes" | "No"
  static String? cardiovascularDisease;    // "Yes" | "No"
  static String? diabetes;                // "Yes" | "No"
  static String? depression;              // "Yes" | "No"
  static String? headInjury;              // "Yes" | "No"
  static String? hypertension;            // "Yes" | "No"
  static double? systolicBP;             // 90 – 180
  static double? diastolicBP;            // 60 – 120
  static double? cholesterolHDL;         // 20 – 100
  static double? mmse;                   // 0 – 30
  static double? functionalAssessment;   // 0 – 10
  static double? adl;                    // 0 – 10

  // ── Page 4: Cognitive Symptoms ──────────────────────
  static String? memoryComplaints;       // "Yes" | "No"
  static String? behavioralProblems;     // "Yes" | "No"
  static String? confusion;             // "Yes" | "No"
  static String? disorientation;        // "Yes" | "No"
  static String? personalityChanges;    // "Yes" | "No"
  static String? difficultyTasks;       // "Yes" | "No"
  static String? forgetfulness;         // "Yes" | "No"
}