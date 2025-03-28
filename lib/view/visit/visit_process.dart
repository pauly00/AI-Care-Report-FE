import 'package:flutter/material.dart';
import 'package:safe_hi/service/audio_service.dart';
import 'package:safe_hi/service/websocket_service.dart';
import 'package:safe_hi/view/visit/visit_check1.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_two_btn.dart';

class VisitProcess extends StatefulWidget {
  const VisitProcess({super.key});

  @override
  VisitProcessState createState() => VisitProcessState();
}

class VisitProcessState extends State<VisitProcess>
    with SingleTickerProviderStateMixin {
  //final audioService = AudioWebSocketRecorder();
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    // 회전 애니메이션 무한 반복
    _rotateController.repeat();
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const DefaultBackAppBar(title: '실시간 대화'),
            // 녹음 진행중 표시 애니메이션 (회전 애니메이션)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RotationTransition(
                      turns: _rotateController,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.fiber_manual_record,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '녹음이 진행중입니다...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomTwoButton(
              buttonText1: '이전 대화',
              buttonText2: '     상담 종료     ',
              onButtonTap1: () {},
              onButtonTap2: () async {
                //await audioService.stopRecording();
                WebSocketService().disconnect();
                if (!mounted) return;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Check1()),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
