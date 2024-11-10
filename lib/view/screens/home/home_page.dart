import 'package:flutter/material.dart';
import 'package:safe_hi/view/widgets/base/navigation_service.dart'; // NavigationService 임포트
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/home/recent_card.dart';
import 'package:safe_hi/view/widgets/visit/visit_list_card.dart';
import 'package:safe_hi/view/widgets/base/bottom_menubar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 방문 정보 리스트 정의
    final visits = [
      {
        'id': 1,
        'tag': '고위험군',
        'time': '10:00 AM',
        'name': '이유진',
        'address': '대전 서구 대덕대로 150',
        'addressDetails': '경성큰마을아파트 102동 103호',
      },
      {
        'id': 2,
        'tag': '고위험군',
        'time': '11:00 AM',
        'name': '김연우',
        'address': '대전 유성구 테크노 3로 23',
        'addressDetails': '테크노 파크 501호',
      },
      {
        'id': 3,
        'tag': '고위험군',
        'time': '1:00 PM',
        'name': '오민석',
        'address': '대전 중구 계룡로 15',
        'addressDetails': '대전 아파트 202호',
      },
      {
        'id': 4,
        'tag': '고위험군',
        'time': '3:00 PM',
        'name': '한민우',
        'address': '대전 서구 둔산로 123',
        'addressDetails': '푸른숲아파트 102동 1202호',
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F6),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopMenubar(
                  title: '안심하이',
                  showBackButton: false,
                ),
                const Text(
                  '김민수 케어 매니저님, 반갑습니다 👋🏻',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                // 네모 박스
                Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB5457),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '오늘 방문할 가구는 총 5곳 입니다.',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '오늘도 파이팅입니다.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 파이차트
                      SizedBox(
                        width: 55,
                        height: 55,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/pie.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                // RecentCard 목록
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      RecentCard(title: "코멘트", count: 5, subtitle: "최근 코멘트"),
                      RecentCard(
                          title: "일정 관리", count: 3, subtitle: "방문 일자 미정 리스트"),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Text(
                      '📆 오늘의 방문 일정 ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '5개',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFB5457),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // VisitCard 목록 생성
                for (var visit in visits)
                  VisitCard(
                    id: visit['id']! as int,
                    tag: visit['tag']! as String, // 필수 매개변수 전달
                    time: visit['time']! as String,
                    name: visit['name']! as String,
                    address: visit['address']! as String,
                    addressDetails: visit['addressDetails']! as String,
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomMenubar(
          currentIndex: 0,
          navigationService: NavigationService(),
        ),
      ),
    );
  }
}
