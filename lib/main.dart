import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/home_page.dart';
import 'package:safe_hi/view/screens/mypage.dart';
import 'package:safe_hi/view/screens/previous_record_page.dart';
import 'package:safe_hi/view/screens/visit_list_page.dart';
import 'package:safe_hi/view/widgets/bottom_menubar.dart'; // BottomMenubar 추가
import 'package:safe_hi/view/widgets/top_menubar.dart'; // TopMenubar 추가

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  // 페이지 제목을 매핑하는 Map
  final Map<int, String> pageTitles = {
    0: '안심하이', // 홈
    1: '10월 현황', // 방문리스트
    2: '이전기록', // 이전 기록
    3: '마이페이지', // 마이페이지
  };

  // 현재 페이지에 맞는 제목을 반환하는 함수
  String getTitle() {
    return pageTitles[currentPageIndex] ?? '안심하이'; // 기본 제목
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopMenubar(title: getTitle()), // 상단 메뉴바에 제목 전달
      backgroundColor: const Color(0xFFFFF6F6), // 배경색 설정
      bottomNavigationBar: BottomMenubar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index; // 페이지 변경 시 상태 업데이트
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0), // 좌우 32px 패딩
        child: <Widget>[
          const HomePage(),
          const VisitListPage(),
          const PreviousRecordsPage(),
          const MyPage(),
        ][currentPageIndex],
      ),
    );
  }
}
