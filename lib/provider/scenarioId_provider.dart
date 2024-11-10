import 'package:flutter/material.dart';

class ScenarioIdProvider with ChangeNotifier {
  int _selectedIndex = 0; // 초기값 설정

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // 변경 사항 알림
  }
}
