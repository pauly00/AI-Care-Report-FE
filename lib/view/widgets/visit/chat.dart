import 'package:flutter/material.dart';

class ChatUI extends StatelessWidget {
  final List<Map<String, dynamic>> chatData;

  const ChatUI({Key? key, required this.chatData}) : super(key: key);

  Widget _buildChatBubble(Map<String, dynamic> message) {
    final isLeft = message['speaker'] == 1; // 1: 왼쪽, 2: 오른쪽
    return Row(
      mainAxisAlignment:
          isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(maxWidth: 250),
          decoration: BoxDecoration(
            color: isLeft ? Color(0xFFEBE7E7) : Color(0xFFFDD8DA),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
                  isLeft ? const Radius.circular(0) : const Radius.circular(12),
              bottomRight:
                  isLeft ? const Radius.circular(12) : const Radius.circular(0),
            ),
          ),
          child: Text(
            message['text'],
            style: TextStyle(
              color: Color(0xFF433A3A),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatData.length,
      itemBuilder: (context, index) {
        return _buildChatBubble(chatData[index]);
      },
    );
  }
}
