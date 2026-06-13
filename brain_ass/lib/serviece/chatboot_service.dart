// serviece/chatbot_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  static const String baseUrl = "http://10.0.2.2:5000";

  static Future<Map<String, dynamic>?> sendMessage(String query) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/chat"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"query": query}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print("ChatbotService error: $e");
      return null;
    }
  }
}