import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AudioComponent extends StatefulWidget {
  const AudioComponent({super.key});

  @override
  State<AudioComponent> createState() => _AudioComponentState();
}

class _AudioComponentState extends State<AudioComponent> {
  Duration duration = Duration.zero; // 총 시간
  Duration position = Duration.zero; // 진행 중인 시간

  // 녹음에 필요한 것들
  final recorder = sound.FlutterSoundRecorder();
  bool isRecording = false; // 녹음 상태
  String audioPath = ''; // 녹음 중단 시 경로 받아올 변수
  String playAudioPath = ''; // 저장할 때 받아올 변수, 재생 시 필요

  // 재생에 필요한 것들
  final AudioPlayer audioPlayer = AudioPlayer(); // 오디오 파일을 재생하는 기능 제공
  bool isPlaying = false; // 현재 재생 중인지

  @override
  void initState() {
    super.initState();
    initRecorder(); // 마이크 권한 요청 및 녹음 초기화
    playAudio();

    // 재생 상태가 변경될 때마다 상태를 감지하는 이벤트 핸들러
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    // 재생 파일의 전체 길이를 감지하는 이벤트 핸들러
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // 재생 중인 파일의 현재 위치를 감지하는 이벤트 핸들러
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio() async {
    try {
      if (isPlaying) {
        await audioPlayer.stop(); // 이미 재생 중인 경우 정지
      }

      await audioPlayer.setSourceDeviceFile(playAudioPath);
      await audioPlayer.resume(); // 재생 시작
      setState(() {
        isPlaying = true;
      });
      audioPlayer.play;
    } catch (e) {
      print("오디오 재생 중 오류 발생: $e");
    }
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  // 녹음 시작
  Future record() async {
    if (!isRecording) {
      await recorder.startRecorder(toFile: 'audio');
      setState(() {
        isRecording = true;
      });
    }
  }

  // 저장 함수
  Future<String> saveRecordingLocally() async {
    if (audioPath.isEmpty) return ''; // 녹음된 오디오 경로가 비어있으면 빈 문자열 반환

    final audioFile = File(audioPath);
    if (!audioFile.existsSync()) return ''; // 파일이 존재하지 않으면 빈 문자열 반환

    try {
      final directory = await getApplicationDocumentsDirectory();
      final newPath = p.join(directory.path, 'recordings');
      final newFile = File(p.join(newPath, 'audio.wav'));

      if (!(await newFile.parent.exists())) {
        await newFile.parent.create(recursive: true); // recordings 디렉터리가 없으면 생성
      }

      await audioFile.copy(newFile.path); // 기존 파일을 새로운 위치로 복사
      playAudioPath = newFile.path;

      return newFile.path; // 새로운 파일의 경로 반환
    } catch (e) {
      print('Error saving recording: $e');
      return ''; // 오류 발생 시 빈 문자열 반환
    }
  }

  // 녹음 중지 & 녹음된 파일의 경로를 가져옴 및 저장
  Future<void> stop() async {
    final path = await recorder.stopRecorder();
    audioPath = path!;

    setState(() {
      isRecording = false;
    });

    final savedFilePath = await saveRecordingLocally();
    print("savedFilePath: $savedFilePath");

    // 다시 녹음 준비
    await initRecorder(); // 마이크 권한 요청 및 녹음 초기화
  }

  String formatTime(Duration duration) {
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
            children: [
              SliderTheme(
                data: SliderThemeData(inactiveTrackColor: Colors.grey),
                child: Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    setState(() {
                      position = Duration(seconds: value.toInt());
                    });
                    await audioPlayer.seek(position);
                  },
                  activeColor: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(position),
                      style: TextStyle(color: Colors.brown),
                    ),
                    SizedBox(width: 20),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.transparent,
                      child: IconButton(
                        padding: EdgeInsets.only(bottom: 50),
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.brown,
                        ),
                        iconSize: 25,
                        onPressed: () async {
                          if (isPlaying) {
                            await audioPlayer.pause();
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            await playAudio();
                            await audioPlayer.resume();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      formatTime(duration),
                      style: TextStyle(color: Colors.brown),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 50),
        IconButton(
          onPressed: () async {
            if (isRecording) {
              await stop();
            } else {
              await record();
            }
            setState(() {});
          },
          icon: Icon(
            isRecording ? Icons.stop : Icons.mic,
            size: 30,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
