import 'package:flutter/material.dart';

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
    return Container(
      color: const Color(0xFFFFF6F6), // 배경색
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
        children: [
          ElevatedButton(
            onPressed: onButtonTap1, // 첫 번째 버튼 클릭 시 콜백 호출
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // 배경색

              side: const BorderSide(
                color: Color(0xFFFB5457),
                width: 2,
              ), // 테두리 색상
              padding: const EdgeInsets.symmetric(
                  horizontal: 35, vertical: 20), // 패딩
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 모서리 반경 설정
              ),
            ),
            child: Text(
              buttonText1,
              style: const TextStyle(
                color: Color(0xFFFB5457), // 텍스트 색상
                fontSize: 17, // 폰트 크기 설정
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 18), // 버튼 간격 설정
          ElevatedButton(
            onPressed: onButtonTap2, // 두 번째 버튼 클릭 시 콜백 호출
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFB5457), // 배경 색상
              padding: const EdgeInsets.symmetric(
                  horizontal: 35, vertical: 20), // 패딩
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 모서리 반경 설정
              ),
            ),
            child: Text(
              buttonText2,
              style: const TextStyle(
                color: Colors.white, // 텍스트 색상
                fontSize: 17, // 폰트 크기 설정
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
