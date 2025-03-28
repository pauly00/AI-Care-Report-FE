import 'package:flutter/material.dart';
import 'package:safe_hi/view/report/report_2.dart';
import 'package:safe_hi/view/report/widget/report_step_header.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';

class Report1 extends StatelessWidget {
  const Report1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F6),
        body: Column(
          children: [
            DefaultBackAppBar(title: '돌봄 리포트'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: const ReportStepHeader(
                    currentStep: 1,
                    totalSteps: 6,
                    stepTitle: 'step 1',
                    stepSubtitle: '기본 정보',
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: BottomOneButton(
            buttonText: '다음',
            onButtonTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Report2()),
              );
            },
          ),
        ),
      ),
    );
  }
}
