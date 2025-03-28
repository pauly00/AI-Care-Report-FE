import 'package:flutter/material.dart';
import 'package:safe_hi/view/visit/visit_detail_page.dart';

class VisitCard extends StatelessWidget {
  final int id;
  final String time; // 시간
  final String name; // 이름
  final String address; // 주소
  final String addressDetails; // 상세 주소

  const VisitCard({
    super.key,
    required this.id,
    required this.time,
    required this.name,
    required this.address,
    required this.addressDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisitDetail(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
