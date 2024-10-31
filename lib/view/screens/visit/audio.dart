import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AudioRecorder {
  // 싱글톤 인스턴스 생성
  static final AudioRecorder _instance = AudioRecorder._internal();

  // 외부에서 AudioRecorder 인스턴스를 가져올 수 있도록 하는 factory 생성자
  factory AudioRecorder() {
    return _instance;
  }

  // 내부 생성자
  AudioRecorder._internal();

  sound.FlutterSoundRecorder? recorder;
  bool isRecording = false; // 녹음 상태
  String audioPath = ''; // 녹음된 오디오 파일 경로

  // 초기화 함수
  Future<void> initRecorder() async {
    recorder ??= sound.FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      debugPrint('마이크 권한이 없습니다.');
      throw '마이크 권한이 없습니다.';
    }
    await recorder!.openRecorder();
    debugPrint("녹음기 초기화 완료");
  }

  // 녹음 시작 함수
  Future<void> startRecording() async {
    if (isRecording) {
      debugPrint("이미 녹음 중입니다.");
      return;
    }

    if (recorder == null) {
      await initRecorder();
    }
    debugPrint("startRecording 함수 실행 !!");

    try {
      await recorder!.startRecorder(toFile: 'audio');
      isRecording = true;
      debugPrint("녹음 시작");
    } catch (e) {
      debugPrint("녹음 시작 중 오류 발생: $e");
      isRecording = false;
    }

    debugPrint("isRecording 상태는 : $isRecording");
  }

  // 녹음 중지 함수
  Future<void> stopRecording() async {
    debugPrint("stopRecording 녹음 중지!!");

    try {
      final path = await recorder!.stopRecorder();
      audioPath = path!;
      isRecording = false;
      debugPrint("녹음 중지: $audioPath");

      final savedFilePath = await saveRecordingLocally();
      audioPath = savedFilePath;
      debugPrint("audioPath : $audioPath");

      await sendToServerWav();

      // 녹음기가 열려 있으면 닫고, 인스턴스 삭제
      if (recorder != null) {
        await recorder!.closeRecorder();
        recorder = null;
      }
    } catch (e) {
      debugPrint("녹음 중지 중 오류 발생: $e");
    }
  }

  // 저장 함수
  Future<String> saveRecordingLocally() async {
    if (audioPath.isEmpty) return '';

    final audioFile = File(audioPath);
    if (!audioFile.existsSync()) return '';

    try {
      final directory = await getApplicationDocumentsDirectory();
      final newPath = p.join(directory.path, 'recordings');
      final newFile = File(p.join(newPath, 'audio.wav'));

      if (!(await newFile.parent.exists())) {
        await newFile.parent.create(recursive: true);
      }

      await audioFile.copy(newFile.path);
      debugPrint("녹음 파일 저장 완료: ${newFile.path}");
      return newFile.path;
    } catch (e) {
      debugPrint('Error saving recording: $e');
      return '';
    }
  }

  // 서버 전송 함수
  Future<void> sendToServerWav() async {
    debugPrint("서버 보내는 함수 실행 !!");

    final Uri uri = Uri.parse('http://101.79.9.58:3000/upload');

    if (audioPath.isEmpty) {
      debugPrint('No audio file to send.');
      return;
    }

    File audioFile = File(audioPath);
    if (!await audioFile.exists()) {
      debugPrint('녹음 파일이 존재하지 않습니다: ${audioFile.path}');
      return;
    }

    try {
      var request = http.MultipartRequest('POST', uri)
        ..files.add(
          await http.MultipartFile.fromPath(
            'audio',
            audioFile.path,
            contentType: MediaType('audio', 'wav'),
          ),
        );

      var response = await request.send();
      if (response.statusCode == 200) {
        debugPrint('File sent successfully! 서버에 전송 성공 !!');
      } else {
        debugPrint('Failed to send file: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error sending file: $e');
    }
  }
}
