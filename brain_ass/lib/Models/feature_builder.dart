// feature_builder.dart
import 'package:untitled3/Models/encoding.dart';
import 'package:untitled3/Models/shard_data_alzahimer.dart';

/// 26 features in exact training order:
/// ['Age','EducationLevel','BMI','Smoking','AlcoholConsumption',
///  'PhysicalActivity','SleepQuality','FamilyHistoryAlzheimers',
///  'CardiovascularDisease','Diabetes','Depression','HeadInjury',
///  'Hypertension','SystolicBP','DiastolicBP','CholesterolHDL',
///  'MMSE','FunctionalAssessment','MemoryComplaints',
///  'BehavioralProblems','ADL','Confusion','Disorientation',
///  'PersonalityChanges','DifficultyCompletingTasks','Forgetfulness']
List<double> buildFeatures() {
  return [
    SharedData.age?.toDouble() ?? 0,                              // Age
    educationToDouble(SharedData.education ?? "None"),            // EducationLevel
    SharedData.bmi ?? 0,                                          // BMI
    yesNoToDouble(SharedData.smokingStatus ?? "No"),              // Smoking
    SharedData.alcoholConsumption ?? 0,                           // AlcoholConsumption
    SharedData.physicalActivity ?? 0,                             // PhysicalActivity
    SharedData.sleepQuality ?? 4.0,                               // SleepQuality
    yesNoToDouble(SharedData.familyHistory ?? "No"),              // FamilyHistoryAlzheimers
    yesNoToDouble(SharedData.cardiovascularDisease ?? "No"),      // CardiovascularDisease
    yesNoToDouble(SharedData.diabetes ?? "No"),                   // Diabetes
    yesNoToDouble(SharedData.depression ?? "No"),                 // Depression
    yesNoToDouble(SharedData.headInjury ?? "No"),                 // HeadInjury
    yesNoToDouble(SharedData.hypertension ?? "No"),               // Hypertension
    SharedData.systolicBP ?? 120,                                 // SystolicBP
    SharedData.diastolicBP ?? 80,                                 // DiastolicBP
    SharedData.cholesterolHDL ?? 50,                              // CholesterolHDL
    SharedData.mmse ?? 15,                                        // MMSE
    SharedData.functionalAssessment ?? 5,                         // FunctionalAssessment
    yesNoToDouble(SharedData.memoryComplaints ?? "No"),           // MemoryComplaints
    yesNoToDouble(SharedData.behavioralProblems ?? "No"),         // BehavioralProblems
    SharedData.adl ?? 5,                                          // ADL
    yesNoToDouble(SharedData.confusion ?? "No"),                  // Confusion
    yesNoToDouble(SharedData.disorientation ?? "No"),             // Disorientation
    yesNoToDouble(SharedData.personalityChanges ?? "No"),         // PersonalityChanges
    yesNoToDouble(SharedData.difficultyTasks ?? "No"),            // DifficultyCompletingTasks
    yesNoToDouble(SharedData.forgetfulness ?? "No"),              // Forgetfulness
  ];
}