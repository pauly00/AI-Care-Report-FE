import 'package:flutter/material.dart';
import 'package:safe_hi/view/report/report_5.dart';
import 'package:safe_hi/view/report/widget/report_step_header.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_two_btn.dart';

class Report4 extends StatelessWidget {
  const Report4({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F6),
        body: Column(
          children: [
            DefaultBackAppBar(title: '돌봄 리포트'),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: const ReportStepHeader(
                  currentStep: 4,
                  totalSteps: 6,
                  stepTitle: 'step 4',
                  stepSubtitle: '정책 추천',
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomTwoButton(
          buttonText1: '이전',
          buttonText2: '             다음             ',
          onButtonTap1: () {
            Navigator.pop(context);
          },
          onButtonTap2: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Report5()),
            );
          },
        ),
      ),
    );
  }
}
