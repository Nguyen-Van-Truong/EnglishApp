import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class EssayEvaluationService {
  final String baseUrl;

  EssayEvaluationService({required this.baseUrl});

  Future<Map<String, dynamic>> evaluateEssay(String id, String instruction, String submission) async {
    // Trả về kết quả mẫu cho API evaluateEssay
    return Future.delayed(
      Duration(seconds: 0), // Giả lập độ trễ mạng
          () => {
        "criteria": [
          {
            "TA": "The response fails to meet the requirements of the task in terms of content, organization, and language. The writer does not provide a clear and coherent discussion of both views on the topic, and the response is poorly organized and lacks cohesion. The language used is also inaccurate and imprecise.",
            "score": "2"
          },
          {
            "CC": "The student's essay is only partially coherent and cohesive. They have made some attempt to organise their ideas and use cohesive devices, but there are still some errors and inconsistencies. Overall, the essay is difficult to follow and understand.",
            "score": "3"
          },
          {
            "LR": "The student's lexical resource is generally good, but there are a number of errors that could be corrected. The student should also try to use a wider range of vocabulary, including more complex words and phrases.",
            "score": "3"
          },
          {
            "GRA": "The student has used a variety of grammatical structures, including complex sentences and compound sentences. However, the student has made several grammatical errors, including incorrect verb tenses, subject-verb agreement errors, and pronoun errors. Overall, the student's grammatical range and accuracy are not yet at a level that would be expected of a native speaker.",
            "score": "3"
          }
        ],
        "band_score": 3.0
      },
    );
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

  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((RegExpMatch match) => debugPrint(match.group(0)));
  }
}
