import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:5000";

  static Future<Map<String, dynamic>?> sendImage(File image) async {
    try {
      final url = Uri.parse("$baseUrl/predict_tumor");

      final request = http.MultipartRequest('POST', url);

      request.files.add(
        await http.MultipartFile.fromPath('file', image.path),
      );

      final response = await request.send();
      final resBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final data = jsonDecode(resBody.body);

        return {
          "prediction": data["prediction"],
          "confidence": data["confidence"],
        };
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("API error: $e");
      return null;
    }
  }
}