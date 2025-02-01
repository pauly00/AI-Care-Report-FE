import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/service/http_service.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';
import 'package:safe_hi/view/widgets/visit/chat.dart';
import 'package:safe_hi/view/widgets/visit/checklist_category_card.dart';
import 'package:safe_hi/view/screens/visit/visit_checklist_qa.dart';

class CheckListCategory extends StatefulWidget {
  final List<String> titles;

  const CheckListCategory({super.key, required this.titles});

  @override
  _CheckListCategoryState createState() => _CheckListCategoryState();
}

class _CheckListCategoryState extends State<CheckListCategory> {
  int selectedIndex = -1;
  bool isLoading = true;
  List<Map<String, dynamic>> chatData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (widget.titles.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 1)); // 로딩 시뮬레이션
    }

    final fetchedChatData = await fetchChatData(context); // 더미 데이터 불러오기
    setState(() {
      chatData = fetchedChatData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                TopMenubar(
                  title: '대화 가이드라인',
                  showBackButton: true,
                ),
                if (!isLoading) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          '카드 중 하나를 선택하여',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff433A3A),
                          ),
                        ),
                        Text(
                          '맞춤형 대화 가이드라인을 확인해보세요.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff433A3A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  BottomOneButton(
                    buttonText: '다음',
                    onButtonTap: () async {
                      if (selectedIndex != -1) {
                        final questions =
                            await fetchQuestions(context, selectedIndex + 1);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CheckListQA(questions: questions),
                          ),
                        );
                      }
                    },
                    isEnabled: selectedIndex != -1,
                  ),
                ],
                // ChatUI 부분
                if (chatData.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ChatUI(chatData: chatData),
                    ),
                  ),
              ],
            ),
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
