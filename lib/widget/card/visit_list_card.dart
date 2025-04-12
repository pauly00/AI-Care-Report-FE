// lib/widget/card/visit_list_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/util/responsive.dart';
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
    final responsive = Responsive(context);

    return GestureDetector(
      onTap: () {
        final viewModel = context.read<VisitViewModel>();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisitDetailPage(
              visitId: id,
              viewModel: viewModel,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(responsive.itemSpacing),
        margin: EdgeInsets.only(bottom: responsive.sectionSpacing),
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
                  style: TextStyle(
                    fontSize: responsive.fontBase,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: responsive.fontBase - 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // 주소
            Text(
              address,
              style: TextStyle(
                fontSize: responsive.fontSmall,
                color: const Color(0xFFB3A5A5),
              ),
            ),
            Text(
              addressDetails,
              style: TextStyle(
                fontSize: responsive.fontSmall,
                color: const Color(0xFFB3A5A5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
