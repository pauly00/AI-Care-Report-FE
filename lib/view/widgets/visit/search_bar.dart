import 'package:flutter/material.dart';

class VisitSearchBar extends StatelessWidget {
  const VisitSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 검색 아이콘
          const Icon(
            Icons.search, // 검색 이모티콘
            color: Colors.grey,
            size: 24,
          ),
          const SizedBox(width: 10), // 간격
          // 힌트 텍스트
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: '검색', // 힌트 텍스트
                hintStyle: TextStyle(
                  color: Color(0xFFB3A5A5),
                  fontSize: 16,
                ),
                border: InputBorder.none, // 기본 테두리 제거
              ),
            ),
          ),
        ],
      ),
    );
  }
}
