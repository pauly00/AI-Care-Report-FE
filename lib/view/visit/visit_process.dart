import 'package:flutter/material.dart';
import 'package:safe_hi/service/audio_service.dart';
import 'package:safe_hi/service/websocket_service.dart';
import 'package:safe_hi/view/visit/visit_check1.dart';
import 'package:safe_hi/view/visit/widget/exit_btn.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';

class VisitProcess extends StatefulWidget {
  const VisitProcess({Key? key}) : super(key: key);

  @override
  _VisitProcessState createState() => _VisitProcessState();
}

class _VisitProcessState extends State<VisitProcess>
    with SingleTickerProviderStateMixin {
  final audioService = AudioWebSocketRecorder();
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.8,
      upperBound: 1.2,
    );

    // 무한 반복 애니메이션
    _pulseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulseController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _pulseController.forward();
      }
    });
    _pulseController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Stack(
          children: [
            // 상단 부분
            Column(
              children: [
                const DefaultBackAppBar(title: '대화 가이드라인'),
                const SizedBox(height: 70),
                // 녹음중 표시 애니메이션
                Expanded(
                  flex: 3,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final scale = _pulseController.value;
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              '녹음이 진행중입니다...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Exit 버튼
            ExitButton(
              onPressed: () async {
                await audioService.stopRecording();
                WebSocketService().disconnect();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Check1()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
