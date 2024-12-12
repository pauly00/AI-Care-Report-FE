import 'package:flutter/material.dart';
import 'package:safe_hi/view/widgets/base/bottom_menubar.dart';
import 'package:safe_hi/view/widgets/base/navigation_service.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/visit/search_bar.dart';
import 'package:safe_hi/view/widgets/visit/visit_record_card.dart';

class PreviousRecordsPage extends StatelessWidget {
  const PreviousRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        'tag': '중위험군',
        'time': '11:00 AM',
        'name': '김연우',
        'address': '대전 유성구 테크노 3로 23',
        'addressDetails': '테크노 파크 501호',
      },
      {
        'id': 3,
        'tag': '저위험군',
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
      {
        'id': 5,
        'tag': '고위험군',
        'time': '3:00 PM',
        'name': '이정선',
        'address': '대전 동구 둔산로 455',
        'addressDetails': '푸른숲아파트 102동 1202호',
      },
      {
        'id': 6,
        'tag': '고위험군',
        'time': '3:00 PM',
        'name': '남예준',
        'address': '대전 서구 둔산로 123',
        'addressDetails': '푸른숲아파트 102동 1202호',
      },
      {
        'id': 6,
        'tag': '고위험군',
        'time': '3:00 PM',
        'name': '이준학',
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
              children: [
                TopMenubar(
                  title: '이전 기록',
                  showBackButton: false,
                ),
                const SizedBox(height: 20),
                VisitSearchBar(),
                for (var visit in visits)
                  VisitRecordCard(
                    id: visit['id']! as int,
                    tag: visit['tag']! as String, // 필수 매개변수 전달
                    name: visit['name']! as String,
                    address: visit['address']! as String,
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomMenubar(
          currentIndex: 2,
          navigationService: NavigationService(),
        ),
      ),
    );
  }
}
