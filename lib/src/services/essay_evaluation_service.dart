// lib/src/services/essay_evaluation_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class EssayEvaluationService {
  final String baseUrl;

  EssayEvaluationService({required this.baseUrl});

  Future<Map<String, dynamic>> evaluateEssay(String id, String instruction, String submission) async {
    final url = Uri.parse('$baseUrl/evaluate');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'instruction': instruction,
        'submission': submission,
        'keys': [],
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to evaluate essay');
    }
  }
}
