import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/audio.dart';
import 'package:safe_hi/view/screens/visit/service/http_service.dart';
import 'package:safe_hi/view/screens/visit/visit_check1.dart';
import 'package:safe_hi/view/screens/visit/visit_checklist_category.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';
import 'package:safe_hi/view/widgets/visit/exit_btn.dart';

class CheckListQA extends StatefulWidget {
  final List<String> questions; // 질문 리스트를 받을 필드 추가

  const CheckListQA({super.key, required this.questions}); // 생성자에 questions 추가

  @override
  _CheckListQAState createState() => _CheckListQAState();
}

class _CheckListQAState extends State<CheckListQA>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<String> _displayedMessages = [];
  late AnimationController _animationController;
  bool _isLoading = true; // 로딩 상태 변수

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
    for (var i = 0; i < widget.questions.length; i++) {
      await Future.delayed(const Duration(seconds: 1));
      _displayedMessages.add(widget.questions[i]);
      _listKey.currentState?.insertItem(_displayedMessages.length - 1);

      // 첫 번째 메시지가 추가된 후 로딩 상태 변경
      if (i == 0) {
        setState(() {
          _isLoading = false; // 로딩 상태를 false로 업데이트
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioRecorder = AudioRecorder();
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                TopMenubar(
                  title: '대화 가이드라인',
                  showBackButton: true,
                ),
                const SizedBox(height: 70),
                Expanded(
                  child: Stack(
                    children: [
                      AnimatedList(
                        key: _listKey,
                        initialItemCount: _displayedMessages.length,
                        itemBuilder: (context, index, animation) {
                          return _buildMessageAnimation(
                              _displayedMessages[index], animation);
                        },
                      ),
                      if (_isLoading)
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.pinkAccent),
                          ),
                        ),
                    ],
                  ),
                ),
                BottomOneButton(
                  buttonText: '완료',
                  onButtonTap: () async {
                    await audioRecorder.stopRecording();
                    List<String> categoryTitles =
                        await fetchCategoryTitles(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CheckListCategory(titles: categoryTitles),
                      ),
                    );
                    await audioRecorder.startRecording();
                  },
                ),
              ],
            ),
            ExitButton(
              onPressed: () {
                audioRecorder.stopRecording();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Check1(),
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
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
