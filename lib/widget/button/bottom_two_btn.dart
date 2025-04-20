import 'package:flutter/material.dart';
import 'package:safe_hi/util/responsive.dart'; // Responsive 클래스 경로 맞게 수정해줘

class BottomTwoButton extends StatelessWidget {
  final String buttonText1;
  final String buttonText2;
  final VoidCallback? onButtonTap1;
  final VoidCallback? onButtonTap2;

  const BottomTwoButton({
    super.key,
    required this.buttonText1,
    required this.buttonText2,
    this.onButtonTap1,
    this.onButtonTap2,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      color: const Color(0xFFFFF6F6),
      padding: EdgeInsets.symmetric(
        horizontal: responsive.paddingHorizontal,
        vertical: responsive.itemSpacing,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onButtonTap1,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(
                color: Color(0xFFFB5457),
                width: 2,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: responsive.isTablet ? 40 : 30,
                vertical: responsive.isTablet ? 22 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              buttonText1,
              style: TextStyle(
                color: const Color(0xFFFB5457),
                fontSize: responsive.fontBase,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: responsive.itemSpacing * 2), // 버튼 간격
          ElevatedButton(
            onPressed: onButtonTap2,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFB5457),
              padding: EdgeInsets.symmetric(
                horizontal: responsive.isTablet ? 40 : 30,
                vertical: responsive.isTablet ? 22 : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              buttonText2,
              style: TextStyle(
                color: Colors.white,
                fontSize: responsive.fontBase,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
