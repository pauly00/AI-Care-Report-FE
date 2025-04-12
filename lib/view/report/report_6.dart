import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/provider/nav/bottom_nav_provider.dart';
import 'package:safe_hi/view/report/widget/report_step_header.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';
import 'package:safe_hi/main_screen.dart';

class Report6 extends StatelessWidget {
  const Report6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            DefaultBackAppBar(title: '돌봄 리포트'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const ReportStepHeader(
                      currentStep: 6,
                      totalSteps: 6,
                      stepTitle: '2025.03.26 (수)',
                      stepSubtitle: 'OOO 어르신 돌봄 리포트',
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '돌봄 리포트가 완성되었습니다',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '완성된 파일을 다운받아 확인해보세요!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // 공유 기능 연결 예정
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 24),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFEAEA),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: const [
                                          Icon(Icons.share,
                                              size: 32, color: Colors.black87),
                                          SizedBox(height: 8),
                                          Text('공유하기',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // 다운로드 기능 연결 예정
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 24),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFEAEA),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: const [
                                          Icon(Icons.download_rounded,
                                              size: 32, color: Colors.black87),
                                          SizedBox(height: 8),
                                          Text('다운로드',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BottomOneButton(
          buttonText: '닫기',
          onButtonTap: () {
            Provider.of<BottomNavProvider>(context, listen: false).setIndex(0);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
