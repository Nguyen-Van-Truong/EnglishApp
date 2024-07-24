import 'dart:convert';
import 'package:englishapp/src/utils/basic_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class EssayEvaluationService {
  final String baseUrl;

  EssayEvaluationService({required this.baseUrl});

  Future<Map<String, dynamic>> evaluateEssay(String id, String instruction, String submission) async {
    final url = Uri.parse('$baseUrl/evaluate');
    final requestBody = jsonEncode({
      'id': id,
      'instruction': instruction,
      'submission': submission,
      'keys': [],
    });

    printLongString('Request to evaluateEssay API: $requestBody');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      printLongString('Response from evaluateEssay API: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to evaluate essay');
    }
  }

  Future<Map<String, dynamic>> generateErrors(String id, String instruction, String submission) async {
    final url = Uri.parse('$baseUrl/generate_errors');
    final requestBody = jsonEncode({
      'id': id,
      'instruction': instruction,
      'submission': submission,
      'keys': [],
    });

    printLongString('Request to generateErrors API: $requestBody');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      printLongString('Response from generateErrors API: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to generate errors');
    }
  }


}
