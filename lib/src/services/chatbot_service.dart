// lib/src/services/chatbot_service.dart
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'dart:async';

class ChatbotService {
  final String baseUrl;
  final StreamController<String> _streamController = StreamController<String>();

  ChatbotService({required this.baseUrl});

  void listenToSSE(Function(String) onEvent) {
    print('--Listen TO SSE---');
    // SSEClient.subscribeToSSE(
    //   method: SSERequestType.POST,
    //   url: '$baseUrl/api/webhook',
    //   header: {
    //     "Accept": "text/event-stream",
    //     "Content-Type": "application/json",
    //   },
    //   body: {
    //     "message": "hello",
    //     "sender": "1"
    //   },
    // ).listen((event) {
    //   print('Received event: ${event.data}');
    //   if (event.data != null) {
    //     _streamController.add(event.data!);
    //   }
    // }, onError: (e) {
    //   print('Error: $e');
    // });

    _streamController.stream.listen(onEvent);
  }

  void sendMessage(String message) {
    SSEClient.subscribeToSSE(
      method: SSERequestType.POST,
      url: '$baseUrl/api/webhook',
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
      if (event.data != null) {
        _streamController.add(event.data!);
      }
    }, onError: (e) {
      print('Error: $e');
    });

  }

  void dispose() {
    _streamController.close();
  }
}
