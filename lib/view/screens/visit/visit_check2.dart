import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/service/http_service.dart';
import 'package:safe_hi/view/screens/visit/visit_comment.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';

class Check2 extends StatefulWidget {
  const Check2({super.key});

  @override
  _Check2State createState() => _Check2State();
}

class _Check2State extends State<Check2> {
  final List<String> checklistItems = [
    '집 안에 약 봉투가 계속 쌓여있다.',
    '집 안의 온도와 무관하게 맞지 않는 옷을 입고 있다.',
    '집 주변에 파리, 구더기 등 벌레가 보이고 악취가 난다.',
  ];

  // 체크박스 상태를 저장할 리스트
  List<bool> isChecked = List.generate(3, (_) => false);

  // 상태 변화 체크박스 변수
  int? selectedMealCondition; // 식사 기능 상태
  int? selectedCognitiveCondition; // 인지 기능 상태
  int? selectedCommunicationCondition; // 의사 기능 상태

  // 모든 체크가 완료되었는지 확인하는 메소드
  bool _isAllChecked() {
    return selectedMealCondition != null &&
        selectedCognitiveCondition != null &&
        selectedCommunicationCondition != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            // TopMenubar 추가
            TopMenubar(
              title: '현장체크         ',
              showBackButton: true,
            ),
            const SizedBox(height: 10),

            // 제목 추가
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '상태 변화 관리',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              // Expanded로 스크롤 가능한 영역을 설정
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 체크리스트 항목 생성
                    ...checklistItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      String item = entry.value;
                      return _buildChecklistItem(index, item);
                    }),
                    const SizedBox(height: 10),

                    // 상태 변화 체크박스 - 식사 기능
                    _buildConditionSection('식사 기능', (value) {
                      setState(() {
                        selectedMealCondition = value;
                      });
                    }, selectedMealCondition),

                    const SizedBox(height: 10),

                    // 상태 변화 체크박스 - 인지 기능
                    _buildConditionSection('인지 기능', (value) {
                      setState(() {
                        selectedCognitiveCondition = value;
                      });
                    }, selectedCognitiveCondition),

                    const SizedBox(height: 10),

                    // 상태 변화 체크박스 - 의사 기능
                    _buildConditionSection('의사 기능', (value) {
                      setState(() {
                        selectedCommunicationCondition = value;
                      });
                    }, selectedCommunicationCondition),
                  ],
                ),
              ),
            ),
            // 하단 버튼 추가
            BottomOneButton(
              buttonText: '다음',
              onButtonTap: () async {
                // fetchConversationSummary API 호출하여 데이터 가져오기
                var conversationSummary =
                    await fetchConversationSummary(context);

                // 데이터를 VisitComment 페이지로 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisitComment(
                      summaryData:
                          conversationSummary, // VisitComment에서 사용할 데이터 전달
                    ),
                  ),
                );
              },
              isEnabled: _isAllChecked(), // 버튼 활성화 여부 설정
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(int index, String item) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 8.0, horizontal: 16.0), // 항목 간 간격
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDD8DA).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // 약간 아래로 그림자 이동
          ),
        ],
      ),
      child: ListTile(
        leading: Checkbox(
          value: isChecked[index], // 체크박스 상태
          activeColor: const Color(0xFFFB5457), // 체크 시 색상
          onChanged: (bool? value) {
            setState(() {
              isChecked[index] = value!; // 상태 업데이트
            });
          },
        ),
        title: Text(
          item,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16, // 텍스트 크기
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildConditionSection(
      String title, Function(int?) onChanged, int? selectedCondition) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFDD8DA).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2), // 약간 아래로 그림자 이동
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16), // 텍스트와 체크박스 간 간격
                _buildConditionCheckbox('양호', 0, onChanged, selectedCondition),
                _buildConditionCheckbox('보통', 1, onChanged, selectedCondition),
                _buildConditionCheckbox('불량', 2, onChanged, selectedCondition),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionCheckbox(String label, int index,
      Function(int?) onChanged, int? selectedCondition) {
    return Row(
      children: [
        Checkbox(
          value: selectedCondition == index,
          activeColor: const Color(0xFFFB5457),
          onChanged: (bool? value) {
            onChanged(value! ? index : null);
          },
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
