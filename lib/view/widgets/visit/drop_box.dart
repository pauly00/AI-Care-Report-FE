import 'package:flutter/material.dart';

class DropdownCard extends StatefulWidget {
  final String title; // 드롭박스 제목
  final Widget content; // 드롭박스 내용 (다양한 디자인 가능)

  const DropdownCard({super.key, required this.title, required this.content});

  @override
  State<DropdownCard> createState() => _DropdownCardState();
}

class _DropdownCardState extends State<DropdownCard> {
  bool isExpanded = false; // 드롭박스 열림/닫힘 상태 관리

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          ListTile(
            title: Text(
              widget.title, // 제목 표시
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.expand_less : Icons.expand_more, // 아이콘 변경
            ),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded; // 클릭 시 열림/닫힘 상태 전환
              });
            },
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: widget.content, // 각기 다른 디자인의 content 표시
            ),
        ],
      ),
    );
  }
}
