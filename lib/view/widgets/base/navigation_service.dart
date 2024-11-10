import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/home/home_page.dart';
import 'package:safe_hi/view/screens/visit/visit_list_page.dart';
import 'package:safe_hi/view/screens/record/previous_record_page.dart';
import 'package:safe_hi/view/screens/mypage/mypage.dart';

class NavigationService {
  // 페이지 목록 정의
  final List<Widget> pages = [
    HomePage(),
    //VisitListPage(),
    //PreviousRecordsPage(),
    //MyPage(),
  ];

  // 선택된 페이지로 이동하는 메소드
  void navigateToPage(BuildContext context, int index) {
    if (index >= 0 && index < pages.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => pages[index]),
      );
    }
  }
}
