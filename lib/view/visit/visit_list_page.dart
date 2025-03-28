import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:safe_hi/widget/appbar/default_appbar.dart';
import 'package:safe_hi/widget/card/visit_list_card.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class VisitListPage extends StatelessWidget {
  const VisitListPage({super.key});

  // 로케일 초기화 Future
  Future<void> _initializeLocale() async {
    await initializeDateFormatting('ko_KR', null);
    Intl.defaultLocale = 'ko_KR';
  }

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
    ];

    return FutureBuilder(
      future: _initializeLocale(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('오류 발생: ${snapshot.error}'));
        }

        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFFFF6F6),
            body: Column(
              children: [
                DefaultAppBar(title: '방문 리스트'),
                Flexible(
                  flex: 0,
                  child: CalendarWeek(
                    backgroundColor: const Color(0xFFFFF6F6),
                    controller: CalendarWeekController(),
                    pressedDateBackgroundColor: Color(0xFFFB5457),
                    dayOfWeekStyle: TextStyle(color: Color(0xFF433A3A)),
                    todayDateStyle: TextStyle(color: Color(0xFFFB5457)),
                    dateStyle: TextStyle(color: Color(0xFF433A3A)),
                    height: 120,
                    showMonth: true,
                    minDate: DateTime.now().add(Duration(days: -365)),
                    maxDate: DateTime.now().add(Duration(days: 365)),
                    onDatePressed: (DateTime datetime) {
                      // 날짜 클릭 시 동작
                    },
                    onDateLongPressed: (DateTime datetime) {
                      // 날짜 길게 클릭 시 동작
                    },
                    onWeekChanged: () {},
                    dayOfWeek: ['월', '화', '수', '목', '금', '토', '일'], // 한글 요일 설정
                    month: const [
                      '1월',
                      '2월',
                      '3월',
                      '4월',
                      '5월',
                      '6월',
                      '7월',
                      '8월',
                      '9월',
                      '10월',
                      '11월',
                      '12월',
                    ],
                    monthViewBuilder: (DateTime time) => Align(
                      alignment: FractionalOffset.center,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          DateFormat.yMMMM().format(time),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF433A3A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    decorations: [
                      DecorationItem(
                        decorationAlignment: FractionalOffset.bottomRight,
                        date: DateTime.now(),
                        decoration: Icon(Icons.today, color: Color(0xFF433A3A)),
                      ),
                      DecorationItem(
                        date: DateTime.now().add(Duration(days: 3)),
                        decoration: Text(
                          '휴일',
                          style: TextStyle(
                            color: Color(0xFF433A3A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: visits.length,
                    itemBuilder: (context, index) {
                      final visit = visits[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: VisitCard(
                          id: visit['id']! as int,
                          time: visit['time']! as String,
                          name: visit['name']! as String,
                          address: visit['address']! as String,
                          addressDetails: visit['addressDetails']! as String,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
