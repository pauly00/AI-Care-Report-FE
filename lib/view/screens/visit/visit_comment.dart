import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/visit_welfare_recommend.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';

class VisitComment extends StatelessWidget {
  const VisitComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            // TopMenubar 추가
            TopMenubar(
              title: '상담코멘트         ',
              showBackButton: true,
            ),
            const SizedBox(height: 20),
            Expanded(
              // Expanded로 스크롤 가능한 영역을 설정
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 요약 섹션
                      Text(
                        '요약',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // 요약 내용 박스
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFDD8DA).withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          '할머니께서는 최근 날씨가 갑자기 쌀쌀해져 무릎이 시리다고 하셨습니다. 온찜질을 제안드렸고, 찜질팩을 다음 방문 때 가져오기로 했습니다. 최근에는 박 여사님과 공원과 시장에 다녀오셨고, 고구마를 사서 구워 드셨으나 혼자 하는 게 재미없다고 하셨습니다. 다음번 고구마 구울 때 같이 하기로 했습니다. 또한, 내 고향 친구라는 TV 프로그램을 즐겨보고 계시며, 옛날 이야기와 시골 풍경이 마음을 편안하게 해준다고 하셨습니다. 예전 고구마를 함께 구워 먹던 추억을 그리워하셨습니다.', // 요약 내용
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 상담 코멘트 작성 제목
                      Text(
                        '상담 코멘트 작성',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 상담 코멘트 입력칸 박스
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFDD8DA).withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          maxLines: 3, // 여러 줄 입력 가능
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '상담 코멘트를 입력하세요...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            // 하단 버튼 추가
            BottomOneButton(
              buttonText: '완료',
              onButtonTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelfareRecommend(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
