import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/home/home_page.dart';
import 'package:safe_hi/view/screens/mypage/mypage.dart';
import 'package:safe_hi/view/screens/record/previous_record_page.dart';
import 'package:safe_hi/view/screens/visit/visit_list_page.dart';
import 'package:safe_hi/view/widgets/base/bottom_menubar.dart'; // BottomMenubar 추가
import 'package:safe_hi/view/widgets/base/top_menubar.dart'; // TopMenubar 추가

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    const VisitListPage(),
    const PreviousRecordsPage(),
    const MyPage(),
  ];

  final Map<int, String> pageTitles = {
    0: '안심하이', // 홈
    1: '10월 현황', // 방문리스트
    2: '이전기록', // 이전 기록
    3: '마이페이지', // 마이페이지
  };

  String getTitle() {
    return pageTitles[currentPageIndex] ?? '안심하이'; // 기본 제목
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      bottomNavigationBar: BottomMenubar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0), // 좌우 32px 패딩
          child: Column(
            children: [
              TopMenubar(title: getTitle()), // 상단 메뉴바 추가
              Expanded(
                child: SingleChildScrollView(
                  // 스크롤 가능한 영역으로 설정
                  child: pages[currentPageIndex],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
