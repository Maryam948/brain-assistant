import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000";

  static Future<Map<String, dynamic>?> sendFeatures(List<double> features) async {
    try {
      final url = Uri.parse("$baseUrl/predict"); 

      final body = jsonEncode({
        "features": features,
      });

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey("prediction") && data.containsKey("probability")) {
          return {
            "prediction": data["prediction"],
            "probability": data["probability"],
          };
        } else {
          print("Invalid response keys: ${data.keys}");
          return null;
        }
      } else {
        print("API returned status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("API error: $e");
      return null;
    }
  }
}
