import 'package:flutter/material.dart';
import 'package:safe_hi/service/websocket_service.dart';
import 'package:safe_hi/view/visit/visit_check1.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_two_btn.dart';
import 'package:safe_hi/util/responsive.dart';

class VisitProcess extends StatefulWidget {
  const VisitProcess({super.key});

  @override
  VisitProcessState createState() => VisitProcessState();
}

class VisitProcessState extends State<VisitProcess>
    with SingleTickerProviderStateMixin {
  // final audioService = AudioWebSocketRecorder();

  final List<String> _sttTexts = [
    '안녕하세요.',
    '오늘 몸 상태는 어떠세요?',
    '무릎 통증은 좀 어떠신가요?'
  ];

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const DefaultBackAppBar(title: '실시간 대화'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: responsive.paddingHorizontal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: Container(
                        padding: EdgeInsets.all(responsive.itemSpacing),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red.shade200, Colors.red.shade400],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: responsive.iconSize,
                        ),
                      ),
                    ),
                    SizedBox(height: responsive.itemSpacing),
                    Text(
                      '어르신의 말씀을 하나하나 담고 있어요 :)',
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: responsive.fontBase + 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: responsive.sectionSpacing),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: responsive.screenHeight * 0.45,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: responsive.itemSpacing),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsive.itemSpacing),
                        itemCount: _sttTexts.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: responsive.itemSpacing),
                        itemBuilder: (context, index) =>
                            _buildBubble(_sttTexts[index], responsive),
                      ),
                    ),
                  ],
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
        child: BottomTwoButton(
          buttonText1: '이전 대화',
          buttonText2: '상담 종료',
          onButtonTap1: () {},
          onButtonTap2: () async {
            // await audioService.stopRecording();

            //WebSocketService().disconnect();
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
      ),
    );
  }

  Widget _buildBubble(String text, Responsive responsive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: responsive.itemSpacing),
          child: Icon(
            Icons.chat_bubble_outline,
            color: Colors.red.shade300,
            size: responsive.iconSize * 0.55,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(responsive.itemSpacing * 0.85),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.red.shade100, width: 1),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: responsive.fontBase,
                color: Colors.grey.shade900,
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
