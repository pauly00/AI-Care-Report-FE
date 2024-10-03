import 'package:flutter/material.dart';

class PreviousRecordsPage extends StatelessWidget {
  const PreviousRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '이전기록 페이지',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
