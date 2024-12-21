import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/service/http_service.dart';
import 'package:safe_hi/view/screens/visit/visit_checklist_qa.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';
import 'package:safe_hi/view/widgets/visit/checklist_category_card.dart'; // CategoryCard import

class CheckListCategory extends StatefulWidget {
  final List<String> titles; // 카테고리 제목을 받을 필드 추가

  const CheckListCategory({super.key, required this.titles}); // 생성자에 titles 추가

  @override
  _CheckListCategoryState createState() => _CheckListCategoryState();
}

class _CheckListCategoryState extends State<CheckListCategory> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            TopMenubar(
              title: '대화 가이드라인',
              showBackButton: true,
            ),
            const SizedBox(height: 10),
            // 안내 문구 추가
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    '카드 중 하나를 선택하여',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff433A3A),
                    ),
                  ),
                  Text(
                    '맞춤형 대화 가이드라인을 확인해보세요.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff433A3A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                        crossAxisCount: 2,
                        childAspectRatio: 140 / 150,
                        children: List.generate(widget.titles.length, (index) {
                          return CategoryCard(
                            title: widget.titles[index], // 카테고리 제목 사용
                            isSelected: selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            BottomOneButton(
              buttonText: '다음',
              onButtonTap: () async {
                debugPrint('Selected Index: $selectedIndex');
                if (selectedIndex != -1) {
                  final questions =
                      await fetchQuestions(context, selectedIndex + 1);
                  uploadCategoryIndex(selectedIndex).then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckListQA(questions: questions),
                      ),
                    );
                  }).catchError((error) {
                    debugPrint('Error uploading category: $error');
                  });
                }
              },
              isEnabled: selectedIndex != -1,
            ),
          ],
        ),
      ),
    );
  }
}
