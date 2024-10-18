import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/visit_detail_page.dart'; // VisitDetail 페이지 임포트

class VisitCard extends StatelessWidget {
  final String tag; // 고위험군 태그
  final String time; // 시간
  final String name; // 이름
  final String address; // 주소
  final String addressDetails; // 상세 주소

  const VisitCard({
    super.key,
    required this.tag,
    required this.time,
    required this.name,
    required this.address,
    required this.addressDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // VisitDetail 페이지로 이동하며 정보 전달 (phone 값은 고정)
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
                // 고위험군 태그
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB5457),
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
                  time, // 시간 표시
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
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
            Text(
              addressDetails, // 상세 주소 표시
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFB3A5A5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
