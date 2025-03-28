import 'package:flutter/material.dart';
import 'package:safe_hi/view/report/widget/report_list_card.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';

class ReportListPage extends StatelessWidget {
  const ReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final visits = [
      {
        'id': 1,
        'time': '10:00 AM',
        'name': '이유진',
        'address': '대전 서구 대덕대로 150',
        'addressDetails': '경성큰마을아파트 102동 103호',
      },
      {
        'id': 2,
        'time': '11:00 AM',
        'name': '김연우',
        'address': '대전 유성구 테크노 3로 23',
        'addressDetails': '테크노 파크 501호',
      },
      {
        'id': 3,
        'time': '1:00 PM',
        'name': '오민석',
        'address': '대전 중구 계룡로 15',
        'addressDetails': '대전 아파트 202호',
      },
      {
        'id': 4,
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
        'time': '3:00 PM',
        'name': '남예준',
        'address': '대전 서구 둔산로 123',
        'addressDetails': '푸른숲아파트 102동 1202호',
      },
      {
        'id': 7,
        'time': '3:00 PM',
        'name': '이준학',
        'address': '대전 서구 둔산로 123',
        'addressDetails': '푸른숲아파트 102동 1202호',
      },
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F6),
        body: Column(
          children: [
            DefaultBackAppBar(title: '돌봄 리포트'),
            Flexible(
              flex: 1,
              child: ListView.builder(
                itemCount: visits.length,
                itemBuilder: (context, index) {
                  final visit = visits[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ReportListCard(
                      id: visit['id']! as int,
                      name: visit['name']! as String,
                      address: visit['address']! as String,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
