// lib/view/visit/visit_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/view_model/visit/visit_list_view_model.dart';
import 'package:safe_hi/widget/appbar/default_appbar.dart';
import 'package:safe_hi/widget/card/visit_list_card.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class VisitListPage extends StatefulWidget {
  const VisitListPage({super.key});

  @override
  State<VisitListPage> createState() => _VisitListPageState();
}

class _VisitListPageState extends State<VisitListPage> {
  final _calController = CalendarWeekController();

  // 로케일 초기화 Future
  Future<void> _initializeLocale() async {
    await initializeDateFormatting('ko_KR', null);
    Intl.defaultLocale = 'ko_KR';
  }

  @override
  void initState() {
    super.initState();
    // 첫 빌드가 끝난 후 "오늘 방문자" 조회
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VisitViewModel>().fetchTodayVisits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeLocale(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('오류 발생: ${snapshot.error}'));
        }

        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFFFF6F6),
            body: Column(
              children: [
                const DefaultAppBar(title: '방문 리스트'),
                Flexible(
                  flex: 0,
                  child: CalendarWeek(
                    controller: _calController,
                    backgroundColor: const Color(0xFFFFF6F6),
                    pressedDateBackgroundColor: const Color(0xFFFB5457),
                    dayOfWeekStyle: const TextStyle(color: Color(0xFF433A3A)),
                    todayDateStyle: const TextStyle(color: Color(0xFFFB5457)),
                    dateStyle: const TextStyle(color: Color(0xFF433A3A)),
                    height: 120,
                    showMonth: true,
                    minDate: DateTime.now().add(const Duration(days: -365)),
                    maxDate: DateTime.now().add(const Duration(days: 365)),
                    onDatePressed: (DateTime datetime) {
                      // 날짜 클릭 시 ViewModel 통해 서버 호출
                      final dateStr = DateFormat('yyyy-MM-dd').format(datetime);
                      context.read<VisitViewModel>().fetchVisitsByDate(dateStr);
                    },
                    onWeekChanged: () {},
                    dayOfWeek: const ['월', '화', '수', '목', '금', '토', '일'],
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
                          style: const TextStyle(
                            color: Color(0xFF433A3A),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Consumer<VisitViewModel>(
                    builder: (context, visitVM, child) {
                      if (visitVM.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final visits = visitVM.visits;
                      if (visits.isEmpty) {
                        return const Center(child: Text('방문 대상이 없습니다.'));
                      }
                      return ListView.builder(
                        itemCount: visits.length,
                        itemBuilder: (context, index) {
                          final v = visits[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: VisitCard(
                              id: v.reportId,
                              time: v.time,
                              name: v.name,
                              address: v.address,
                              addressDetails: v.addressDetails,
                            ),
                          );
                        },
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
