import 'package:flutter/material.dart';
import 'package:safe_hi/service/audio_service.dart';
import 'package:safe_hi/view/visit/visit_process.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';
import 'package:safe_hi/util/responsive.dart';

class CheckListReady extends StatefulWidget {
  const CheckListReady({super.key});

  @override
  State<CheckListReady> createState() => _CheckListReadyState();
}

class _CheckListReadyState extends State<CheckListReady> {
  @override
  void initState() {
    super.initState();
    // WebSocketService().connect('ws://211.188.55.88:8085');
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    // final audioService = AudioWebSocketRecorder();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const DefaultBackAppBar(title: '실시간 대화'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.paddingHorizontal,
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '체크할 준비가 되었나요?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: responsive.fontXL,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: responsive.itemSpacing),
                      Text(
                        '지금부터 안심하이가 함께 하겠습니다.',
                        style: TextStyle(
                          color: const Color(0xFFB3A5A5),
                          fontSize: responsive.fontBase,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: responsive.sectionSpacing * 3),
                      Image.asset(
                        'assets/images/checklist.png',
                        width: responsive.isTablet ? 300 : 230,
                        height: responsive.isTablet ? 300 : 230,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: responsive.paddingHorizontal,
        ),
        child: BottomOneButton(
          buttonText: '시작하기',
          onButtonTap: () async {
            // await audioService.startRecording();
            if (!mounted) return;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VisitProcess()),
              );
            });
          },
        ),
      ),
    );
  }
}
