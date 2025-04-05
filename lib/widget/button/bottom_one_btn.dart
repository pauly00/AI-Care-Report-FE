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

  // BottomOneButton 위젯 수정
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF6F6),
      padding: const EdgeInsets.symmetric(vertical: 16), // 좌우 패딩 추가
      child: SizedBox(
        width: double.infinity, // 전체 너비 사용
        child: ElevatedButton(
          onPressed: isEnabled ? onButtonTap : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled ? const Color(0xFFFB5457) : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
