import 'package:flutter/material.dart';
import 'package:safe_hi/view/visit/visit_detail_page.dart';

class VisitCard extends StatelessWidget {
  final int id; // 시나리오 id
  final String tag; // 고위험군 태그
  final String time; // 시간
  final String name; // 이름
  final String address; // 주소
  final String addressDetails; // 상세 주소

  const VisitCard({
    super.key,
    required this.id,
    required this.tag,
    required this.time,
    required this.name,
    required this.address,
    required this.addressDetails,
  });

  @override
  Widget build(BuildContext context) {
    Color tagColor;
    if (tag == "고위험군") {
      tagColor = const Color(0xFFFB5457); // 고위험군 색상
    } else if (tag == "중위험군") {
      tagColor = const Color(0xFFFB8654); // 중위험군 색상
    } else {
      tagColor = const Color(0xFFFBC254); // 저위험군 색상
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisitDetail(
              tag: tag,
              name: name,
              address: address,
              addressDetails: addressDetails,
              phone: '010-1234-5678',
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 첫 번째 줄 (태그 + 시간)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 고위험군 태그
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: tagColor, // tagColor 적용
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
                // 시간 표시
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7), // 간격
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              address,
              style: const TextStyle(fontSize: 14, color: Color(0xFFB3A5A5)),
            ),
            Text(
              addressDetails,
              style: const TextStyle(fontSize: 14, color: Color(0xFFB3A5A5)),
            ),
          ],
        ),
      ),
    );
  }
}
