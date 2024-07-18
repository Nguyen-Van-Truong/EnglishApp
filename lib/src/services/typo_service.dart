// lib/src/services/typo_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class TypoService {
  final String baseUrl;

  TypoService({required this.baseUrl});

  Future<String> fixTypos(String id, String submission) async {
    final url = Uri.parse('$baseUrl/fix_typos');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'submission': submission,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['fixed_typos'];
    } else {
      throw Exception('Failed to fix typos');
    }
  }
}
