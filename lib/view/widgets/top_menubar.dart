import 'package:flutter/material.dart';

class TopMenubar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopMenubar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF6F6), // 배경색 설정
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 21.0), // 위, 아래 21px 패딩
        child: Align(
          alignment: title == '안심하이'
              ? Alignment.centerLeft // '안심하이'는 왼쪽 정렬
              : Alignment.center, // 나머지는 중앙 정렬
          child: Row(
            mainAxisSize: MainAxisSize.min, // 텍스트와 이미지 크기만큼만 공간 사용
            children: [
              Transform.translate(
                offset: const Offset(0, 3), // Y축으로 4픽셀 아래로 이동
                child: Image.asset(
                  'assets/images/logoicon.png', // 이미지 경로
                  width: 30, // 이미지 크기 설정
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 2), // 이미지와 텍스트 사이 간격
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFFB5457), // 텍스트 색상
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar 높이 설정
  @override
  Size get preferredSize =>
      const Size.fromHeight(56.0 + 42.0); // 기본 높이 + 패딩(21 * 2)
}
