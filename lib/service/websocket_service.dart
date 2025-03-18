import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  // --- 1) Singleton 설정 ---
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  // --- 2) WebSocketChannel 보관 ---
  WebSocketChannel? _channel;

  bool get isConnected => _channel != null;

  // --- 3) 서버에 WebSocket 연결 ---
  Future<void> connect(String url) async {
    if (_channel == null) {
      try {
        _channel = IOWebSocketChannel.connect('ws://211.188.55.88:8085');
        debugPrint('[WebSocket] 연결 성공!');

        // 서버로부터 오는 메시지를 수신할 수도 있음
        _channel!.stream.listen((message) {
          debugPrint('[WebSocket] 서버메시지: $message');
        }, onError: (error) {
          debugPrint('[WebSocket] 에러: $error');
          // 필요시 재연결 로직 등
          _channel = null;
        }, onDone: () {
          debugPrint('[WebSocket] 연결 종료됨');
          _channel = null;
        });
      } catch (e) {
        debugPrint('[WebSocket] 연결 실패: $e');
        _channel = null;
      }
    }
  }

  // --- 4) 연결 종료 ---
  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }

  // --- 5) 메시지 전송 (여기서는 Base64 인코딩된 오디오 청크 등) ---
  void sendMessage(String data) {
    if (_channel != null) {
      _channel!.sink.add(data);
    } else {
      debugPrint('[WebSocket] 연결 안됨! 메시지 전송 불가');
    }
  }
}
