import 'package:flutter/material.dart';
import 'package:safe_hi/view/widgets/base/bottom_menubar.dart';
import 'package:safe_hi/view/widgets/base/navigation_service.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';

class VisitListPage extends StatelessWidget {
  const VisitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F6),
        body: Column(
          children: [
            TopMenubar(
              title: '10월 현황',
              showBackButton: false,
            ),
            Text(
              '방문리스트 페이지',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        bottomNavigationBar: BottomMenubar(
          currentIndex: 1,
          navigationService: NavigationService(),
        ),
      ),
    );
  }
}
