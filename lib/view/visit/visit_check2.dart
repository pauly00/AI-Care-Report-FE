import 'package:flutter/material.dart';
import 'package:safe_hi/view/visit/visit_welfare_recommend.dart';
import 'package:safe_hi/view_model/visit/visit_policy_view_model.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';
import 'package:provider/provider.dart';

class Check2 extends StatelessWidget {
  const Check2({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VisitPolicyViewModel>(
          create: (_) => VisitPolicyViewModel(),
        ),
      ],
      child: const _Check2Body(),
    );
  }
}

class _Check2Body extends StatefulWidget {
  const _Check2Body();

  @override
  State<_Check2Body> createState() => _Check2BodyState();
}

class _Check2BodyState extends State<_Check2Body> {
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
    final vmPolicy = context.watch<VisitPolicyViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            // TopMenubar 추가
            DefaultBackAppBar(
              title: '현장체크',
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...checklistItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      String item = entry.value;
                      return _buildChecklistItem(index, item);
                    }),
                    const SizedBox(height: 10),
                    _buildConditionSection('식사 기능', (value) {
                      setState(() {
                        selectedMealCondition = value;
                      });
                    }, selectedMealCondition),
                    const SizedBox(height: 10),
                    _buildConditionSection('인지 기능', (value) {
                      setState(() {
                        selectedCognitiveCondition = value;
                      });
                    }, selectedCognitiveCondition),
                    const SizedBox(height: 10),
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
                // 복지 정책 가져오기
                final welfareList = await vmPolicy.fetchWelfarePolicies();
                if (!mounted) return;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;

                  // 다음 화면 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WelfareRecommend(welfareData: welfareList),
                    ),
                  );
                });
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
            color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
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
              color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
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
