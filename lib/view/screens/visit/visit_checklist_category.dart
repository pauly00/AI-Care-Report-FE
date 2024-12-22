import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/service/http_service.dart'; // API 호출 함수 임포트
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';
import 'package:safe_hi/view/widgets/visit/checklist_category_card.dart'; // CategoryCard import
import 'package:safe_hi/view/screens/visit/visit_checklist_qa.dart'; // 다른 화면으로 이동

class CheckListCategory extends StatefulWidget {
  final List<String> titles; // titles를 받아오는 필드

  const CheckListCategory({super.key, required this.titles});

  @override
  _CheckListCategoryState createState() => _CheckListCategoryState();
}

class _CheckListCategoryState extends State<CheckListCategory> {
  int selectedIndex = -1;
  bool isLoading = true; // 로딩 상태 변수

  @override
  void initState() {
    super.initState();
    _updateLoadingState(); // isLoading 상태를 업데이트하는 함수 호출
  }

  // isLoading 상태를 업데이트하는 비동기 함수
  Future<void> _updateLoadingState() async {
    if (widget.titles.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Stack(
          children: [
            // 기본 화면 내용
            Column(
              children: [
                TopMenubar(
                  title: '대화 가이드라인',
                  showBackButton: true,
                ),
                const SizedBox(height: 10),
                if (!isLoading) ...[
                  // isLoading이 false일 때만 카테고리 카드와 버튼을 표시
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
                  SingleChildScrollView(
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
                            children:
                                List.generate(widget.titles.length, (index) {
                              return CategoryCard(
                                title: widget.titles[index],
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
                      ],
                    ),
                  ),
                ],
                if (!isLoading) ...[
                  // isLoading이 false일 때만 버튼을 표시
                  const SizedBox(height: 100),
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
                              builder: (context) =>
                                  CheckListQA(questions: questions),
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
              ],
            ),

            // 로딩 중일 때 화면 중앙에 로딩 표시
            if (isLoading)
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
