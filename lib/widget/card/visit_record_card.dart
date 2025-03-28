import 'package:flutter/material.dart';

class VisitRecordCard extends StatelessWidget {
  final int id; // 시나리오 id
  final String name; // 이름
  final String address; // 주소

  const VisitRecordCard({
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
                name, // 이름 표시
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            address, // 주소 표시
            style: const TextStyle(fontSize: 14, color: Color(0xFFB3A5A5)),
          ),
        ],
      ),
    );
  }
}
