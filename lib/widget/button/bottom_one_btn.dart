import 'package:flutter/material.dart';

class BottomOneButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onButtonTap; // 버튼 클릭 시 호출할 콜백
  final bool isEnabled; // 버튼 활성화 여부

  const BottomOneButton({
    super.key,
    required this.buttonText,
    required this.onButtonTap,
    this.isEnabled = true, // 기본값을 true로 설정
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF6F6), // 배경색
      padding: const EdgeInsets.symmetric(vertical: 16), // 위아래 패딩
      child: SizedBox(
        child: ElevatedButton(
          onPressed:
              isEnabled ? onButtonTap : null, // isEnabled에 따라 콜백 호출 여부 결정
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isEnabled ? const Color(0xFFFB5457) : Colors.grey, // 배경 색상
            padding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 20), // 패딩
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // 모서리 반경 설정
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white, // 텍스트 색상
              fontSize: 17, // 폰트 크기 설정
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
