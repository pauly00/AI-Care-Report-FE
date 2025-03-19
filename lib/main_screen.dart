import 'package:flutter/material.dart';
import 'package:safe_hi/provider/nav/bottom_nav_provider.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/widget/bottom_menubar/bottom_menubar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<BottomNavProvider>();
    return Scaffold(
      body: navProvider.pages[navProvider.currentIndex],
      bottomNavigationBar: const BottomMenubar(),
    );
  }
}
