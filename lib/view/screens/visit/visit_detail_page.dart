import 'package:flutter/material.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';

class VisitDetail extends StatelessWidget {
  final String tag; // 고위험군 태그
  final String time; // 시간
  final String name; // 이름
  final String address; // 주소
  final String addressDetails; // 상세 주소

  const VisitDetail({
    super.key,
    required this.tag,
    required this.time,
    required this.name,
    required this.address,
    required this.addressDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            // TopMenubar 추가
            TopMenubar(
              title: '상세 보기           ',
              showBackButton: true,
            ), // 원하는 제목 전달
            const SizedBox(height: 16), // TopMenubar와 내용 사이 간격

            // 방문자 정보 표시
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '방문자 정보',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('이름: $name', style: const TextStyle(fontSize: 16)),
                Text('태그: $tag', style: const TextStyle(fontSize: 16)),
                Text('시간: $time', style: const TextStyle(fontSize: 16)),
                Text('주소: $address', style: const TextStyle(fontSize: 16)),
                Text('상세 주소: $addressDetails',
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
