// CheckListReady.dart
import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/audio.dart';
import 'package:safe_hi/view/screens/visit/service/http_service.dart';
import 'package:safe_hi/view/screens/visit/visit_checklist_category.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';

class CheckListReady extends StatelessWidget {
  const CheckListReady({super.key});

  @override
  Widget build(BuildContext context) {
    final audioRecorder = AudioRecorder();
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            TopMenubar(
              title: '체크리스트        ',
              showBackButton: true,
            ),
            const SizedBox(height: 70),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '체크할 준비가 되었나요?',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '시작에 앞서\n녹음을 진행하겠습니다.',
                        style: const TextStyle(
                          color: Color(0xFFB3A5A5),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Image.asset(
                        'assets/images/checklist.png',
                        width: 230,
                        height: 230,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            BottomOneButton(
              buttonText: '시작하기',
              onButtonTap: () async {
                audioRecorder.startRecording();
                List<String> categoryTitles =
                    await fetchCategoryTitles(); // API 호출
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CheckListCategory(titles: categoryTitles),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
