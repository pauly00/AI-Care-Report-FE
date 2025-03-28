import 'package:flutter/material.dart';
import 'package:safe_hi/service/audio_service.dart';
import 'package:safe_hi/service/websocket_service.dart';
import 'package:safe_hi/view/visit/visit_process.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';

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
    //WebSocketService().connect('ws://211.188.55.88:8085');
  }

  @override
  Widget build(BuildContext context) {
    //final audioService = AudioWebSocketRecorder();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            DefaultBackAppBar(title: '대화 가이드라인'),
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
                          //await audioService.startRecording();
                          if (!mounted) return;
                          // 현재 프레임 종료 후 Navigator 호출
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (!mounted) return;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => VisitProcess()),
                            );
                          });
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
