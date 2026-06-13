import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl ="http://10.0.2.2:5000";

  static Future<Map?> predict(List<double> features) async {
    final response = await http.post(
      Uri.parse("$baseUrl/predict"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"features": features}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }
}