import 'package:flutter/material.dart';

class RecentCard2 extends StatelessWidget {
  final String title;
  final int count;
  final String subtitle;
  final String iconEmoji;

  const RecentCard2({
    super.key,
    required this.title,
    required this.count,
    required this.subtitle,
    required this.iconEmoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 상단 텍스트 부분
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFFB5457),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFB5457),
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFB3A5A5),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                iconEmoji,
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
