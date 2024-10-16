import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '마이페이지',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
