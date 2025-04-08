// lib/widget/card/visit_list_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/view/visit/visit_detail_page.dart';
import 'package:safe_hi/view_model/visit/visit_list_view_model.dart';

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
        final viewModel = context.read<VisitViewModel>(); // ✅ 기존 ViewModel 가져오기

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisitDetailPage(
              visitId: id,
              viewModel: viewModel, // ✅ 전달
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
              color: const Color(0xFFFDD8DA).withAlpha(80),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 행: 이름 + 시간
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
            // 주소
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
