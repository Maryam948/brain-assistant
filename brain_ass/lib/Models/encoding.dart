// encoding.dart

double yesNoToDouble(String v) => v == "Yes" ? 1.0 : 0.0;

double educationToDouble(String v) {
  switch (v) {
    case "None":   return 0;
    case "Low":    return 1;
    case "Medium": return 2;
    case "High":   return 3;
    default:       return 0;
  }
}