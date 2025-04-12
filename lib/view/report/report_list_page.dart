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
        'name': '이유진',
        'address': '대전 서구 대덕대로 150',
        'visitDateTime': DateTime(2025, 4, 3, 10, 0),
      },
      {
        'id': 2,
        'name': '김연우',
        'address': '대전 유성구 테크노 3로 23',
        'visitDateTime': DateTime(2025, 4, 2, 11, 0),
      },
      {
        'id': 3,
        'name': '오민석',
        'address': '대전 중구 계룡로 15',
        'visitDateTime': DateTime(2025, 4, 1, 13, 0),
      },
      {
        'id': 4,
        'name': '한민우',
        'address': '대전 서구 둔산로 123',
        'visitDateTime': DateTime(2025, 3, 31, 15, 0),
      },
      {
        'id': 5,
        'name': '이정선',
        'address': '대전 동구 둔산로 455',
        'visitDateTime': DateTime(2025, 3, 30, 15, 0),
      },
      {
        'id': 6,
        'name': '남예준',
        'address': '대전 서구 둔산로 123',
        'visitDateTime': DateTime(2025, 3, 29, 15, 0),
      },
      {
        'id': 7,
        'name': '이준학',
        'address': '대전 서구 둔산로 123',
        'visitDateTime': DateTime(2025, 3, 28, 15, 0),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const DefaultBackAppBar(title: '돌봄 리포트'),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                itemCount: visits.length + 1, // 설명 1줄 추가
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '📝 아직 제출되지 않은 리포트 목록입니다.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '방문을 완료하셨다면, 리포트를 꼭 제출해주세요!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFB3A5A5),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    );
                  }

                  final visit = visits[index - 1];
                  final visitDateTime = visit['visitDateTime'] as DateTime;

                  return ReportListCard(
                    id: visit['id'] as int,
                    name: visit['name'] as String,
                    address: visit['address'] as String,
                    visitDateTime: visitDateTime,
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
