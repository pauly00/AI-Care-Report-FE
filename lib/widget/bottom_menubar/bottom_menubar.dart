import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/provider/nav/bottom_nav_provider.dart';

class BottomMenubar extends StatelessWidget {
  const BottomMenubar({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider에서 탭 상태를 가져옴
    final navProvider = context.watch<BottomNavProvider>();
    final currentIndex = navProvider.currentIndex;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (newIndex) {
        navProvider.setIndex(newIndex);
      },
      backgroundColor: const Color(0xFFFFF6F6),
      selectedItemColor: const Color(0xFFFB5457),
      unselectedItemColor: const Color(0xFFB3A5A5),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: '방문리스트',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          label: '이전기록',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: '마이페이지',
        ),
      ],
    );
  }
}
