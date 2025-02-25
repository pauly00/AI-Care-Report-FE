import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'websocket_service.dart';

class AudioWebSocketRecorder {
  // --- 1) Singleton 설정 ---
  static final AudioWebSocketRecorder _instance =
      AudioWebSocketRecorder._internal();
  factory AudioWebSocketRecorder() => _instance;
  AudioWebSocketRecorder._internal();

  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  StreamSubscription? _recorderSubscription;

  // --- 2) 초기화 ---
  Future<void> initRecorder() async {
    if (_recorder == null) {
      _recorder = FlutterSoundRecorder();
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw Exception('마이크 권한이 없습니다.');
      }
      await _recorder!.openRecorder();
    }
  }

  // --- 3) WebSocket + 오디오 녹음 시작 ---
  Future<void> startRecording() async {
    if (_isRecording) {
      debugPrint('이미 녹음 중입니다.');
      return;
    }
    await initRecorder(); // 마이크 권한 및 녹음기 초기화

    final ws = WebSocketService(); // WebSocket 싱글톤 (이미 connect() 되어있어야 함)

    // StreamController를 만들어, flutter_sound에서 넘겨주는 PCM 바이트를 받음
    final streamController = StreamController<Food>();

    // 실제로 raw PCM 스트림을 얻기 위한 설정
    await _recorder!.startRecorder(
      toStream: streamController.sink, // 여기서 "toStream"만 지정
      codec: Codec.pcm16, // raw PCM 코덱
      sampleRate: 16000, // 서버 요구사항에 맞게 조정
      numChannels: 1, // 모노
      bitRate: 16 * 1000, // 필요 시 조정
    );

    // streamController를 listen하여, 실시간 오디오 바이트를 처리
    _recorderSubscription = streamController.stream.listen((foodData) {
      // foodData는 보통 "Food" 타입으로, 내부에 raw 바이트가 들어있음
      if (foodData is FoodData) {
        // foodData.data가 실제 PCM byte 배열(Uint8List)
        final Uint8List? audioBytes = foodData.data;
        // Base64로 인코딩하여 WebSocket 전송
        final base64String = base64Encode(audioBytes as List<int>);
        ws.sendMessage(base64String);
      }
    });

    _isRecording = true;
    debugPrint('오디오 녹음 & WebSocket 전송 시작');
  }

  // --- 4) 녹음 중지 ---
  Future<void> stopRecording() async {
    if (!_isRecording) return;
    await _recorderSubscription?.cancel();
    _recorderSubscription = null;

    try {
      await _recorder!.stopRecorder();
      _isRecording = false;
      debugPrint('오디오 녹음 중지');
    } catch (e) {
      debugPrint('녹음 중지 오류: $e');
    }
  }

  // --- 5) 정리 함수 (필요 시) ---
  Future<void> dispose() async {
    await stopRecording();
    await _recorder?.closeRecorder();
    _recorder = null;
  }
}
