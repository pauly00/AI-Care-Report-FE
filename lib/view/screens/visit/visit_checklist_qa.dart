import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/visit_check1.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';

class CheckListQA extends StatefulWidget {
  const CheckListQA({super.key});

  @override
  _CheckListQAState createState() => _CheckListQAState();
}

class _CheckListQAState extends State<CheckListQA>
    with SingleTickerProviderStateMixin {
  final List<String> _messages = [
    '동네 마실이 어땠는지,',
    '마실 다녀온 후 몸 상태는 괜찮으신지 확인.',
    '다른 지인들과의 대화나 교류가 어땠는지',
    '다음에 또 가보고 싶은 장소나 하고 싶은 활동이 있으신지'
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _displayedMessages = [];
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _addMessages();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _addMessages() async {
    for (var message in _messages) {
      await Future.delayed(const Duration(seconds: 1));
      _displayedMessages.add(message);
      _listKey.currentState?.insertItem(_displayedMessages.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            TopMenubar(
              title: '체크리스트         ',
              showBackButton: true,
            ),
            const SizedBox(height: 70),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: _displayedMessages.length,
                itemBuilder: (context, index, animation) {
                  return _buildMessageAnimation(
                      _displayedMessages[index], animation);
                },
              ),
            ),
            BottomOneButton(
              buttonText: '완료',
              onButtonTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Check1(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageAnimation(String message, Animation<double> animation) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        )),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFDD8DA).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
