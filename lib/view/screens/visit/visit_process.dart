import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/visit/service/audio_ws.dart';
import 'package:safe_hi/view/screens/visit/service/http_service.dart';
import 'package:safe_hi/view/screens/visit/service/websocket_service.dart';
import 'package:safe_hi/view/screens/visit/visit_check1.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/visit/chat.dart';
import 'package:safe_hi/view/widgets/visit/exit_btn.dart';

class VisitProcess extends StatefulWidget {
  final List<String> questions;

  const VisitProcess({super.key, required this.questions});

  @override
  _VisitProcessState createState() => _VisitProcessState();
}

class _VisitProcessState extends State<VisitProcess> {
  List<Map<String, dynamic>> chatData = [];
  final audioService = AudioWebSocketRecorder();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final fetchedChatData = await fetchChatData(context);
    setState(() {
      chatData = fetchedChatData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Stack(
          children: [
            // 상단 메뉴바, 채팅 등 메인 콘텐츠
            Column(
              children: [
                TopMenubar(
                  title: '대화 가이드라인',
                  showBackButton: true,
                ),
                const SizedBox(height: 70),
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      if (chatData.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: ChatUI(chatData: chatData),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // Exit 버튼
            ExitButton(
              onPressed: () async {
                await audioService.stopRecording();
                WebSocketService().disconnect();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Check1(),
                  ),
                );
              },
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: screenHeight,
                child: DraggableScrollableSheet(
                  initialChildSize: 0.1,
                  minChildSize: 0.1,
                  maxChildSize: 0.8,
                  builder: (BuildContext context, ScrollController scrollCtrl) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: const Offset(0, -2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: ListView.separated(
                          controller: scrollCtrl,
                          itemCount: widget.questions.length + 2,
                          separatorBuilder: (context, index) {
                            if (index < 2) {
                              return const SizedBox.shrink();
                            } else {
                              return const Divider(
                                height: 1,
                                thickness: 0.5,
                                color: Colors.black12,
                              );
                            }
                          },
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Center(
                                child: Container(
                                  width: 50,
                                  height: 5,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              );
                            } else if (index == 1) {
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 6.0),
                                child: Center(
                                  child: Text(
                                    '이전 대화 기반 추천 대화 주제',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              final questionIndex = index - 2;
                              final question = widget.questions[questionIndex];

                              return ListTile(
                                leading: const Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFFFDD8DA),
                                ),
                                title: Text(
                                  question,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
