import 'package:flutter/material.dart';
import 'package:safe_hi/view/report/report_1.dart';

class ReportListCard extends StatelessWidget {
  final int id; // 시나리오 id
  final String name; // 이름
  final String address; // 주소

  const ReportListCard({
    super.key,
    required this.id,
    required this.name,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 왼쪽: 이름과 주소
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFB3A5A5),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Report1(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Color(0xFFFB5457),
                  size: 18,
                ),
                label: const Text(
                  "리포트 작성",
                  style: TextStyle(
                    color: Color(0xFFFB5457),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFB5457)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
