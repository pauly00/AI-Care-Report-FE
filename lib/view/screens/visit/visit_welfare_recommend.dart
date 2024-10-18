import 'package:flutter/material.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';
import 'package:safe_hi/view/screens/home/home_page.dart';

class WelfareRecommend extends StatelessWidget {
  const WelfareRecommend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            // TopMenubar 추가
            TopMenubar(
              title: 'AI 복지정책',
              showBackButton: true,
            ),
            const SizedBox(height: 10),
            Expanded(
              // Expanded로 스크롤 가능한 영역을 설정
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'AI 추천 복지 서비스',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // 대상자 텍스트
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          children: [
                            const TextSpan(text: '대상자는 '),
                            TextSpan(
                              text: '65세 이상, 저소득층',
                              style: const TextStyle(color: Color(0xFFFB5457)),
                            ),
                            const TextSpan(text: '이자\n'),
                            TextSpan(
                              text: '건강 문제와 심리적 어려움',
                              style: const TextStyle(color: Color(0xFFFB5457)),
                            ),
                            const TextSpan(text: '을 겪고 있는\n'),
                            const TextSpan(text: '상황이므로, 아래 복지 서비스를 추천드립니다.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 첫 번째 박스 - 노인 의료비 지원
                      _buildWelfareBox(
                        title: '노인 의료비 지원',
                        content: '- 대상 : 만 65세 이상의 노인 중 의료비 부담이 큰 경우\n'
                            '- 혜택 : 진료비, 약제비 등 의료비 일부 지원\n'
                            '- 추천 이유 : 무릎통증 및 기타 건강 문제로 병원 방문 필요시 의료비 부담 경감 가능',
                      ),
                      const SizedBox(height: 16),

                      // 두 번째 박스 - 난방비 지원
                      _buildWelfareBox(
                        title: '난방비 지원 (에너지 바우처)',
                        content: '- 대상 : 저소득층 고령자 가구\n'
                            '- 혜택 : 난방비를 충당하기 위한 바우처 제공\n'
                            '- 추천 이유 : 겨울철 무릎 시림과 같은 불편함 해소를 위해 난방비 지원이 유용할 수 있음',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomOneButton(
              buttonText: '완료',
              onButtonTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 복지 정보를 담은 박스를 만드는 위젯
  Widget _buildWelfareBox({required String title, required String content}) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFFB5457), // 제목 색상
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.black, // 내용 색상
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
