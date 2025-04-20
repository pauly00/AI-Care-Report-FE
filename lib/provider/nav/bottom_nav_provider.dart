import 'package:flutter/material.dart';
import 'package:safe_hi/view/home/home_page.dart';
import 'package:safe_hi/view/visit/visit_list_page.dart';
import 'package:safe_hi/view/record/previous_record_page.dart';
import 'package:safe_hi/view/mypage/mypage.dart';

class BottomNavProvider extends ChangeNotifier {
  // 현재 탭 인덱스
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  // 탭별로 보여줄 페이지
  final List<Widget> pages = [
    const HomePage(),
    const VisitListPage(),
    const PreviousRecordsPage(),
    const MyPage(),
  ];

  // 탭 변경 함수
  void setIndex(int newIndex) {
    if (newIndex >= 0 && newIndex < pages.length) {
      _currentIndex = newIndex;
      notifyListeners();
    }
  }
}
