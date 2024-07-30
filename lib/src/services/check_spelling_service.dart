// lib/src/services/check_spelling_service.dart
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'dart:async';

class CheckSpellingService {
  final String baseUrl;
  StreamController<String>? _streamController;

  CheckSpellingService({required this.baseUrl});

  void listenToSSE(Function(String) onEvent) {
    print('--Listen TO SSE---');
    _streamController ??= StreamController<String>.broadcast();
    _streamController!.stream.listen(onEvent);
  }

  void sendMessage(String message) {
    if (_streamController == null || _streamController!.isClosed) {
      _streamController = StreamController<String>.broadcast();
    }

    SSEClient.subscribeToSSE(
      method: SSERequestType.POST,
      url: '$baseUrl/api/spellcheck',
      header: {
        "Accept": "text/event-stream",
        "Content-Type": "application/json",
      },
      body: {
        "message": message,
        "sender": "1"
      },
    ).listen((event) {
      print('Received event:${event.data}');
      if (event.data != null && _streamController != null && !_streamController!.isClosed) {
        _streamController!.add(event.data!);
      }
    }, onError: (e) {
      print('Error: $e');
    });
  }

  void dispose() {
    _streamController?.close();
  }
}
