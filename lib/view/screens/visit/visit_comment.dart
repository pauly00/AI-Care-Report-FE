import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/service/http_service.dart';
import 'package:safe_hi/view/screens/visit/visit_welfare_recommend.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';

class VisitComment extends StatelessWidget {
  final List<Map<String, dynamic>> summaryData; // 대화 요약 데이터 받아오기

  const VisitComment({super.key, required this.summaryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            // TopMenubar 추가
            TopMenubar(
              title: '상담코멘트',
              showBackButton: true,
            ),

            // 하나의 큰 박스 안에 날짜와 내용 포함
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 요약 제목
                      Text(
                        '요약',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 하나의 큰 박스 안에 모든 title과 content 반복
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
                        child: Stack(
                          children: [
                            // 날짜 박스
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB3A5A5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '2024.11.13', // 날짜 수정 가능
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // 요약 제목과 내용 반복
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var summary in summaryData) ...[
                                  // 제목
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFFB5457)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      summary['title'],
                                      style: const TextStyle(
                                        color: Color(0xFFFB5457),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),

                                  // 내용
                                  for (var content in summary['content']) ...[
                                    Text(
                                      content,
                                      style: const TextStyle(
                                        color: Color(0xFFB3A5A5),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                  ],
                                  const SizedBox(height: 10),
                                ],
                              ],
                            ),
                          ],
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
              onButtonTap: () async {
                final welfareData = await fetchWelfarePolicies(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WelfareRecommend(welfareData: welfareData),
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
