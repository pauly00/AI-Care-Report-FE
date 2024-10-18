import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/visit_checklist_qa.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';
import 'package:safe_hi/view/widgets/visit/checklist_category_card.dart'; // CategoryCard import

class CheckListCategory extends StatefulWidget {
  const CheckListCategory({super.key});

  @override
  _CheckListCategoryState createState() => _CheckListCategoryState();
}

class _CheckListCategoryState extends State<CheckListCategory> {
  int selectedIndex = -1; // 선택된 카드를 추적하기 위한 인덱스

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            // TopMenubar 추가
            TopMenubar(
              title: '체크리스트         ',
              showBackButton: true,
            ),
            const SizedBox(height: 70),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2, // 열의 개수
                        childAspectRatio: 140 / 150, // 너비/높이 비율
                        children: [
                          CategoryCard(
                            title: '동네 마실 예정',
                            isSelected: selectedIndex == 0, // 첫 번째 카드 선택 여부
                            onTap: () {
                              setState(() {
                                selectedIndex = 0; // 첫 번째 카드 선택
                              });
                            },
                          ),
                          CategoryCard(
                            title: '무릎 통증으로 10.05(금) 병원 방문예정',
                            isSelected: selectedIndex == 1, // 두 번째 카드 선택 여부
                            onTap: () {
                              setState(() {
                                selectedIndex = 1; // 두 번째 카드 선택
                              });
                            },
                          ),
                          CategoryCard(
                            title: 'TV 프로그램 6시 내고향을 즐겨봄',
                            isSelected: selectedIndex == 2, // 세 번째 카드 선택 여부
                            onTap: () {
                              setState(() {
                                selectedIndex = 2; // 세 번째 카드 선택
                              });
                            },
                          ),
                          CategoryCard(
                            title: '김장에 관련된 이야기, 감장 예정 있으신지',
                            isSelected: selectedIndex == 3, // 네 번째 카드 선택 여부
                            onTap: () {
                              setState(() {
                                selectedIndex = 3; // 네 번째 카드 선택
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32), // 아래 여백 추가
                  ],
                ),
              ),
            ),
            // 하단 버튼 추가
            BottomOneButton(
              buttonText: '다음',
              onButtonTap: () {
                if (selectedIndex != -1) {
                  // 선택된 카드가 있을 때만 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckListQA(),
                    ),
                  );
                }
              },
              isEnabled: selectedIndex != -1, // 선택된 카드가 있을 때만 활성화
            ),
          ],
        ),
      ),
    );
  }
}
