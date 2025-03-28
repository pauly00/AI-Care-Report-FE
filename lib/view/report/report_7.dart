import 'package:flutter/material.dart';
import 'package:safe_hi/view/home/home_page.dart';
import 'package:safe_hi/view/report/widget/report_step_header.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';
import 'package:safe_hi/widget/button/bottom_two_btn.dart';

class Report7 extends StatelessWidget {
  const Report7({super.key});

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
                  currentStep: 7,
                  totalSteps: 6,
                  stepTitle: '2025.03.26 (수)',
                  stepSubtitle: 'OOO 어르신 돌봄 리포트',
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: BottomOneButton(
            buttonText: '완료',
            onButtonTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
