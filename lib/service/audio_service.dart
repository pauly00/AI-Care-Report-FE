import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'websocket_service.dart';

class AudioWebSocketRecorder {
  // 1) 싱글톤 패턴
  static final AudioWebSocketRecorder _instance =
      AudioWebSocketRecorder._internal();
  factory AudioWebSocketRecorder() => _instance;
  AudioWebSocketRecorder._internal();

  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;

  // flutter_sound 9.x 이후에는 raw PCM 스트림이 Uint8List로 전달됨
  StreamSubscription<Uint8List>? _recorderSubscription;

  // 2) 초기화 (녹음 권한 및 Recorder 오픈)
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

  // 3) 녹음 시작 + WebSocket 전송
  Future<void> startRecording() async {
    if (_isRecording) {
      debugPrint('이미 녹음 중입니다.');
      return;
    }
    await initRecorder();

    final ws = WebSocketService(); // WebSocket 싱글톤. 이미 connect() 상태라고 가정

    // flutter_sound에서 전달되는 PCM byte를 담을 StreamController<Uint8List>
    final streamController = StreamController<Uint8List>();

    // startRecorder에 StreamSink<Uint8List>를 연결
    await _recorder!.startRecorder(
      toStream: streamController.sink,
      codec: Codec.pcm16,
      sampleRate: 16000,
      numChannels: 1,
      bitRate: 16 * 1000,
    );

    // 스트림을 청취하면서, 각 청크를 WebSocket으로 전송
    _recorderSubscription = streamController.stream.listen((audioBytes) {
      final base64String = base64Encode(audioBytes);
      ws.sendMessage(base64String);
    });

    _isRecording = true;
    debugPrint('오디오 녹음 & WebSocket 전송 시작');
  }

  // 4) 녹음 중지
  Future<void> stopRecording() async {
    if (!_isRecording) return;

    // 스트림 구독 취소
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

  // 5) 정리 (필요 시)
  Future<void> dispose() async {
    await stopRecording();
    await _recorder?.closeRecorder();
    _recorder = null;
  }
}
