import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safe_hi/view/report/report_1.dart';

class ReportListCard extends StatelessWidget {
  final int id; // 시나리오 id
  final String name; // 이름
  final String address; // 주소
  final DateTime visitDateTime; // 방문 일시 추가

  const ReportListCard({
    super.key,
    required this.id,
    required this.name,
    required this.address,
    required this.visitDateTime,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(visitDateTime);

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDD8DA).withAlpha(80),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 왼쪽: 이름과 주소 + 방문일
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
                const SizedBox(height: 6),
                Text(
                  '📍 주소: $address',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFB3A5A5),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '🕒 최근 방문: $formattedDate',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFB3A5A5),
                  ),
                ),
              ],
            ),
          ),
          // 오른쪽: 버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Report1()),
                  );
                },
                icon: const Icon(Icons.edit_note, size: 20),
                label: const Text(
                  "작성",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFFB5457),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 14),
                  elevation: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
