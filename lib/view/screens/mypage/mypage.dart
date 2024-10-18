import 'package:flutter/material.dart';
import 'package:safe_hi/view/widgets/base/bottom_menubar.dart';
import 'package:safe_hi/view/widgets/base/navigation_service.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F6),
        body: Column(
          children: [
            TopMenubar(
              title: '마이페이지',
              showBackButton: false,
            ),
            Text(
              '마이페이지',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        bottomNavigationBar: BottomMenubar(
          currentIndex: 3,
          navigationService: NavigationService(),
        ),
      ),
    );
  }
}
