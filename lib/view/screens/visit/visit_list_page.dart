import 'package:flutter/material.dart';

class VisitListPage extends StatelessWidget {
  const VisitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '방문리스트 페이지',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
