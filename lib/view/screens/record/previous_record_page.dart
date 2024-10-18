import 'package:flutter/material.dart';
import 'package:safe_hi/view/widgets/base/bottom_menubar.dart';
import 'package:safe_hi/view/widgets/base/navigation_service.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';

class PreviousRecordsPage extends StatelessWidget {
  const PreviousRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF6F6),
        body: Column(
          children: [
            TopMenubar(
              title: '이전 기록',
              showBackButton: false,
            ),
            Text(
              '이전 기록',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        bottomNavigationBar: BottomMenubar(
          currentIndex: 2,
          navigationService: NavigationService(),
        ),
      ),
    );
  }
}
