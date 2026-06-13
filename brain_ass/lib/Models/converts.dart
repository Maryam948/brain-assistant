// converters.dart
double genderToDouble(String gender) => gender == "Male" ? 1.0 : 0.0;
double yesNoToDouble(String value) => value == "Yes" ? 1.0 : 0.0;

double workTypeToDouble(String value) {
  switch (value) {
    case "Govt_job": return 0.0;
    case "Never_worked": return 4.0;
    case "Private": return 2.0;
    case "Self-employed": return 3.0;
    case "children": return 1.0;
    default: return 2.0;
  }
}

double residenceToDouble(String value) => value == "Urban" ? 1.0 : 0.0;

double smokingToDouble(String value) {
  switch (value) {
    case "Unknown": return 0.0;
    case "formerly smoked": return 1.0;
    case "never smoked": return 2.0;
    case "smokes": return 3.0;
    default: return 2.0;
  }
}

