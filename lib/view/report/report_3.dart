import 'package:flutter/material.dart';
import 'package:safe_hi/view/report/report_4.dart';
import 'package:safe_hi/view/report/widget/report_step_header.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_two_btn.dart';
import 'package:safe_hi/util/responsive.dart';

class Report3 extends StatefulWidget {
  const Report3({super.key});

  @override
  State<Report3> createState() => _Report3State();
}

class _Report3State extends State<Report3> {
  List<bool> _isSelected = [true, true];

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const DefaultBackAppBar(title: '돌봄 리포트'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: responsive.paddingHorizontal),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReportStepHeader(
                      currentStep: 3,
                      totalSteps: 6,
                      stepTitle: 'step 3',
                      stepSubtitle: '정책 추천',
                    ),
                    SizedBox(height: responsive.sectionSpacing),
                    Column(
                      children: List.generate(2, (index) {
                        return Container(
                          margin:
                              EdgeInsets.only(bottom: responsive.cardSpacing),
                          padding: EdgeInsets.all(responsive.cardSpacing),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFFDD8DA),
                                blurRadius: 4,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '추천 정책 ${index + 1}. 정책명',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: responsive.fontBase,
                                ),
                              ),
                              SizedBox(height: responsive.itemSpacing),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(responsive.itemSpacing),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFEBE7E7)),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('정책 개요',
                                        style: TextStyle(
                                            fontSize: responsive.fontSmall)),
                                    Text('• 내용',
                                        style: TextStyle(
                                            fontSize: responsive.fontSmall)),
                                    Text('• 내용',
                                        style: TextStyle(
                                            fontSize: responsive.fontSmall)),
                                    SizedBox(height: responsive.itemSpacing),
                                    Text('세부 설명',
                                        style: TextStyle(
                                            fontSize: responsive.fontSmall)),
                                    Text('• 조건',
                                        style: TextStyle(
                                            fontSize: responsive.fontSmall)),
                                    Text('• 기준',
                                        style: TextStyle(
                                            fontSize: responsive.fontSmall)),
                                    SizedBox(height: responsive.itemSpacing),
                                    Text('추천 이유',
                                        style: TextStyle(
                                            fontSize: responsive.fontSmall)),
                                    Text('• AI 추천 이유',
                                        style: TextStyle(
                                            fontSize: responsive.fontSmall)),
                                  ],
                                ),
                              ),
                              SizedBox(height: responsive.itemSpacing),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFFB5457),
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                responsive.itemSpacing * 0.8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      child: Text('자세히 보기',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: responsive.fontSmall)),
                                    ),
                                  ),
                                  SizedBox(width: responsive.itemSpacing),
                                  Checkbox(
                                    value: _isSelected[index],
                                    onChanged: (val) {
                                      setState(() => _isSelected[index] = val!);
                                    },
                                    activeColor: const Color(0xFFFB5457),
                                  ),
                                  Text('선택',
                                      style: TextStyle(
                                          fontSize: responsive.fontSmall,
                                          fontWeight: FontWeight.w500)),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: responsive.paddingHorizontal),
        child: BottomTwoButton(
          buttonText1: '이전',
          buttonText2: '다음'.padLeft(14).padRight(28),
          onButtonTap1: () {
            Navigator.pop(context);
          },
          onButtonTap2: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Report4()),
            );
          },
        ),
      ),
    );
  }
}
