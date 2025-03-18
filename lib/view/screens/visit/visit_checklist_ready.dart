import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/service/audio_ws.dart';
import 'package:safe_hi/view/screens/visit/service/http_service.dart';
import 'package:safe_hi/view/screens/visit/service/websocket_service.dart';
import 'package:safe_hi/view/screens/visit/visit_checklist_category.dart';
import 'package:safe_hi/view/screens/visit/visit_process.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';

class CheckListReady extends StatefulWidget {
  const CheckListReady({super.key});

  @override
  State<CheckListReady> createState() => _CheckListReadyState();
}

class _CheckListReadyState extends State<CheckListReady> {
  @override
  void initState() {
    super.initState();
    // WebSocket 연결
    WebSocketService().connect('ws://211.188.55.88:8085');
  }

  @override
  Widget build(BuildContext context) {
    //final audioRecorder = AudioRecorder();
    final wsService = WebSocketService();
    final audioService = AudioWebSocketRecorder();
    int selectedIndex = -1;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            TopMenubar(
              title: '대화 가이드라인',
              showBackButton: true,
            ),
            const SizedBox(height: 70),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '체크할 준비가 되었나요?',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '지금부터 안심하이가 함께 하겠습니다.',
                        style: const TextStyle(
                          color: Color(0xFFB3A5A5),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Image.asset(
                        'assets/images/checklist.png',
                        width: 230,
                        height: 230,
                      ),
                    ),
                    const SizedBox(height: 100),
                    Center(
                      child: BottomOneButton(
                        buttonText: '시작하기',
                        onButtonTap: () async {
                          // audioRecorder.startRecording();
                          // 현재 페이지 초기화시 websocket 연결했기에 중복 호출 불필요
                          // await wsService().connect('ws://서버주소:포트');

                          // 오디오 녹음 + 실시간 전송 시작
                          await audioService.startRecording();

                          final questions =
                              await fetchQuestions(context, selectedIndex + 1);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VisitProcess(questions: questions),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
