import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/util/responsive.dart';
import 'package:safe_hi/view/home/widget/recent_card2.dart';
import 'package:safe_hi/view/report/report_list_page.dart';
import 'package:safe_hi/view_model/user_view_model.dart';
import 'package:safe_hi/view_model/visit/visit_list_view_model.dart';
import 'package:safe_hi/widget/appbar/default_appbar.dart';
import 'package:safe_hi/widget/card/visit_list_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VisitViewModel>().fetchTodayVisits();
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final visitVM = context.watch<VisitViewModel>();
    final visits = visitVM.visits;
    final userVM = context.watch<UserViewModel>();
    final username = userVM.user?.name ?? 'OOO';

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F6),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: responsive.paddingHorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DefaultAppBar(title: '안심하이'),
                Text(
                  '$username 동행 매니저님, 반갑습니다 👋🏻',
                  style: TextStyle(
                    fontSize: responsive.fontBase,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: responsive.sectionSpacing),
                Container(
                  padding: EdgeInsets.all(responsive.isTablet ? 24 : 17),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB5457),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
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
                          children: [
                            Text(
                              visitVM.isLoading
                                  ? '로딩중...'
                                  : '오늘 방문할 가구는 총 ${visits.length}곳 입니다.',
                              style: TextStyle(
                                fontSize: responsive.fontBase,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '오늘도 파이팅입니다.',
                              style: TextStyle(
                                fontSize: responsive.fontSmall,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: responsive.imageSize,
                        height: responsive.imageSize,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: responsive.sectionSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ReportListPage(),
                            ),
                          );
                        },
                        child: const RecentCard2(
                          title: "리포트 관리",
                          count: 2,
                          subtitle: "미제출된 리포트 리스트",
                          iconEmoji: "📋",
                        ),
                      ),
                    ),
                    SizedBox(width: responsive.cardSpacing),
                    const Expanded(
                      child: RecentCard2(
                        title: "일정 관리",
                        count: 3,
                        subtitle: "방문 일자 미정 리스트",
                        iconEmoji: "⏰",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsive.sectionSpacing),
                Row(
                  children: [
                    Text(
                      '📆 오늘의 방문 일정 ',
                      style: TextStyle(
                        fontSize: responsive.fontLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${visits.length}개',
                      style: TextStyle(
                        fontSize: responsive.fontLarge,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFB5457),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsive.itemSpacing),
                if (visitVM.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  ...visits.map((v) => VisitCard(
                        id: v.id,
                        time: v.time,
                        name: v.name,
                        address: v.address,
                        addressDetails: v.addressDetails,
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
