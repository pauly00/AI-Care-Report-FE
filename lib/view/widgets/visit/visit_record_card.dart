import 'package:flutter/material.dart';

class VisitRecordCard extends StatelessWidget {
  final int id; // 시나리오 id
  final String tag; // 고위험군 태그
  final String name; // 이름
  final String address; // 주소

  const VisitRecordCard({
    super.key,
    required this.id,
    required this.tag,
    required this.name,
    required this.address,
  });

  // 태그 색상 반환 메서드
  Color _getTagColor(String tag) {
    switch (tag) {
      case '고위험군':
        return const Color(0xFFFB5457); // FFFB5457
      case '중위험군':
        return const Color(0xFFFF800A); // FF800A
      case '저위험군':
        return const Color(0xFFFFBD15); // FFBD15
      default:
        return const Color(0xFFB3A5A5); // 기본 색상
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDD8DA).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 태그 표시
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTagColor(tag),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  tag, // 태그 표시
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 7), // 간격
          Text(
            name, // 이름 표시
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            address, // 주소 표시
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFB3A5A5),
            ),
          ),
        ],
      ),
    );
  }
}
