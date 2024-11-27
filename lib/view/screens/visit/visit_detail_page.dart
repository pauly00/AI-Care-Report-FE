import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/visit_checklist_start.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_two_btn.dart';
import 'package:safe_hi/view/widgets/visit/drop_box.dart';

class VisitDetail extends StatelessWidget {
  final String tag; // 고위험군 태그
  final String name; // 이름
  final String address; // 주소
  final String addressDetails; // 상세 주소
  final String phone; // 전화번호

  const VisitDetail({
    super.key,
    required this.tag,
    required this.name,
    required this.address,
    required this.phone,
    required this.addressDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TopMenubar 추가
              TopMenubar(
                title: '상세 보기',
                showBackButton: true,
              ),
              const SizedBox(height: 16),

              // 상단 왼쪽 이름과 태그
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name, // 이름
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10), // 이름과 태그 사이 간격
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag, // 고위험군 태그
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 네모 박스 2개
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    // 첫 번째 박스 (주소)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFDD8DA).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '주소', // 제목
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFB3A5A5),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                address, // 내용
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                addressDetails, // 내용
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 두 번째 박스 (전화번호)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFDD8DA).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '전화번호', // 제목
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFB3A5A5),
                            ),
                          ),
                          Text(
                            phone, // 내용
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Column(
                      children: [
                        DropdownCard(
                          title: '2024년 8월 12일',
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '이전 방문 내용:',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                  '할머니께서는 최근 날씨가 갑자기 쌀쌀해져 무릎이 시리다고 하셨습니다. 온찜질을 제안드렸고, 찜질팩을 다음 방문 때 가져오기로 했습니다. 최근에는 박 여사님과 공원과 시장에 다녀오셨고, 고구마를 사서 구워 드셨으나 혼자 하는 게 재미없다고 하셨습니다. 다음번 고구마 구울 때 같이 하기로 했습니다. 또한, 내 고향 친구라는 TV 프로그램을 즐겨보고 계시며, 옛날 이야기와 시골 풍경이 마음을 편안하게 해준다고 하셨습니다. 예전 고구마를 함께 구워 먹던 추억을 그리워하셨습니다.'),
                            ],
                          ),
                        ),
                        DropdownCard(
                          title: '방문 예약 상태',
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.calendar_today,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text('예약일: 2024년 9월 14일',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFDD8DA).withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('상태: 문자 전송 완료',
                                    style: TextStyle(fontSize: 14)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 80), // 여유 공간 추가하여 버튼을 하단으로 이동
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomTwoButton(
        buttonText1: '방문일자수정',
        buttonText2: '상담시작',
        onButtonTap1: () {
          // '방문일자수정' 버튼 클릭 시 처리할 로직
        },
        onButtonTap2: () {
          // '상담시작' 버튼 클릭 시 CheckList 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckList(), // CheckList 페이지로 이동
            ),
          );
        },
      ),
    );
  }
}
