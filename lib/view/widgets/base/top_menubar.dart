import 'package:flutter/material.dart';

class TopMenubar extends StatelessWidget {
  final String title;
  final bool showBackButton; // 뒤로가기 버튼 표시 여부

  const TopMenubar({
    super.key,
    required this.title,
    this.showBackButton = false, // 기본값은 false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF6F6), // 배경색 설정
      padding: const EdgeInsets.symmetric(vertical: 15.0), // 상하 패딩
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: const Color(0xFFFB5457),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          Expanded(
            child: Align(
              alignment:
                  title == "안심하이" ? Alignment.centerLeft : Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, // 텍스트와 이미지 중앙 정렬
                children: [
                  Transform.translate(
                    offset: const Offset(0, 3), // Y축으로 3픽셀 아래로 이동
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
                    style: TextStyle(
                      color: title == "안심하이"
                          ? const Color(0xFFFB5457)
                          : Colors.black, // "안심하이"일 때는 빨간색, 아니면 검정색
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
