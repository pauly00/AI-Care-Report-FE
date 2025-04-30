import 'package:flutter/material.dart';
import 'package:safe_hi/util/responsive.dart';

class VisitRecordCard extends StatelessWidget {
  final int id;
  final String name;
  final String address;
  final bool isTablet;

  const VisitRecordCard({
    super.key,
    required this.id,
    required this.name,
    required this.address,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final cardPadding =
        isTablet ? responsive.cardSpacing * 1.2 : responsive.cardSpacing;
    final fontSizeTitle =
        isTablet ? responsive.fontBase + 2 : responsive.fontBase;
    final fontSizeSub =
        isTablet ? responsive.fontSmall + 1 : responsive.fontSmall;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: fontSizeTitle,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: responsive.itemSpacing * 0.5),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: fontSizeSub,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: isTablet ? 50 : 28,
            color: Colors.red.shade300,
          ),
        ],
      ),
    );
  }
}
