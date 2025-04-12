import 'package:flutter/material.dart';
import 'package:safe_hi/view/report/report_3.dart';
import 'package:safe_hi/view/report/widget/report_step_header.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_two_btn.dart';

class Report2 extends StatefulWidget {
  const Report2({super.key});

  @override
  State<Report2> createState() => _Report2State();
}

class _Report2State extends State<Report2> {
  bool _isEditing = false;
  List<bool> _isExpandedList = [false, false, false, false];
  List<String> _summaries = [
    '소화 관련 불편 지속적 호소',
    '공과금 부담, 경제적 스트레스 존재',
    '외출 빈도 급감, 활동량 저하 및 무기력감',
    '가족과의 거리감, 사회활동 회피'
  ];
  List<String> _details = [
    '외출 일주일 정도 안함\n누워 있는 것을 매우 선호',
    '전기세 부담 많음\n절약을 위해 밤 불을 잘 안 킴',
    '외출 일주일 정도 안함\n누워 있는 것을 매우 선호',
    '가족과의 교류 없음\n사회적 활동에 소극적'
  ];

  final List<String> _categories = ['건강', '경제', '생활', '기타'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            DefaultBackAppBar(title: '돌봄 리포트'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const ReportStepHeader(
                          currentStep: 2,
                          totalSteps: 6,
                          stepTitle: 'step 2',
                          stepSubtitle: '대화 내용 요약',
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 25,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF4F4),
                              borderRadius: BorderRadius.circular(6),
                              border:
                                  Border.all(color: const Color(0xFFFB5457)),
                            ),
                            child: TextButton(
                              onPressed: () =>
                                  setState(() => _isEditing = !_isEditing),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                      _isEditing
                                          ? Icons.check
                                          : Icons.edit_note_rounded,
                                      size: 16,
                                      color: const Color(0xFFFB5457)),
                                  const SizedBox(width: 4),
                                  Text(_isEditing ? '저장' : '수정',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFFB5457))),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xFFFDD8DA),
                              blurRadius: 4,
                              offset: Offset(0, 0)),
                        ],
                      ),
                      child: Column(
                        children: List.generate(_categories.length, (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('[${_categories[index]}]',
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(height: 6),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isExpandedList[index] =
                                        !_isExpandedList[index];
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFEBE7E7)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: _isEditing
                                                      ? TextFormField(
                                                          initialValue:
                                                              _summaries[index],
                                                          onChanged: (value) =>
                                                              _summaries[
                                                                      index] =
                                                                  value,
                                                          decoration:
                                                              const InputDecoration
                                                                  .collapsed(
                                                                  hintText:
                                                                      '요약 내용을 입력하세요'),
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      : Text(
                                                          _summaries[index],
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                _isExpandedList[index]
                                                    ? '접기'
                                                    : '자세히',
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                              const SizedBox(width: 2),
                                              Transform.rotate(
                                                angle: _isExpandedList[index]
                                                    ? 3.14
                                                    : 0,
                                                child: const Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 18,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      if (_isExpandedList[index])
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: _isEditing
                                              ? TextFormField(
                                                  initialValue: _details[index],
                                                  onChanged: (value) =>
                                                      _details[index] = value,
                                                  maxLines: null,
                                                  decoration:
                                                      const InputDecoration
                                                          .collapsed(
                                                          hintText:
                                                              '세부 내용을 입력하세요'),
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: _details[index]
                                                      .split('\n')
                                                      .map((e) => Text('• $e'))
                                                      .toList(),
                                                ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }),
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
        padding: const EdgeInsets.only(bottom: 32.0),
        child: BottomTwoButton(
          buttonText1: '이전',
          buttonText2: '다음'.padLeft(14).padRight(28),
          onButtonTap1: () {
            Navigator.pop(context);
          },
          onButtonTap2: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Report3()),
            );
          },
        ),
      ),
    );
  }
}
