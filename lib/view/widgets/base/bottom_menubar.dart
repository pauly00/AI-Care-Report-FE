import 'package:flutter/material.dart';
import 'package:safe_hi/view/widgets/base/navigation_service.dart'; // NavigationService 임포트

class BottomMenubar extends StatelessWidget {
  final int currentIndex;
  final NavigationService navigationService;

  const BottomMenubar({
    super.key,
    required this.currentIndex,
    required this.navigationService, // NavigationService를 생성자로 받음
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index != currentIndex) {
          // 선택된 페이지로 이동
          navigationService.navigateToPage(
              context, index); // NavigationService를 통해 페이지 이동
        }
      },
      backgroundColor: const Color(0xFFFFF6F6), // 하단 메뉴 바 배경색 설정
      selectedItemColor: const Color(0xFFFB5457), // 선택된 아이템 색상
      unselectedItemColor: const Color(0xFFB3A5A5), // 선택되지 않은 아이템 색상
      type: BottomNavigationBarType.fixed, // 고정형 하단 네비게이션 바
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_outlined),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          activeIcon: Icon(Icons.list_alt_outlined),
          label: '방문리스트',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          activeIcon: Icon(Icons.history_outlined),
          label: '이전기록',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person_outline),
          label: '마이페이지',
        ),
      ],
    );
  }
}
