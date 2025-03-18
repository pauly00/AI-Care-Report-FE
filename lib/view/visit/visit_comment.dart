// lib/view/visit/visit_comment.dart
import 'package:flutter/material.dart';
import 'package:safe_hi/view/visit/visit_welfare_recommend.dart';
import 'package:provider/provider.dart';

import 'package:safe_hi/view_model/visit/visit_comment_viewmodel.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';

class VisitComment extends StatelessWidget {
  final List<Map<String, dynamic>> summaryData;

  const VisitComment({super.key, required this.summaryData});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VisitCommentViewModel>(
      create: (_) => VisitCommentViewModel(summaryData: summaryData),
      child: const _VisitCommentBody(),
    );
  }
}

class _VisitCommentBody extends StatefulWidget {
  const _VisitCommentBody();

  @override
  State<_VisitCommentBody> createState() => _VisitCommentBodyState();
}

class _VisitCommentBodyState extends State<_VisitCommentBody> {
  @override
  void initState() {
    super.initState();
    // ViewModel 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VisitCommentViewModel>().initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<VisitCommentViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: vm.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFB5457),
                  ),
                ),
              )
            : Column(
                children: [
                  const DefaultBackAppBar(title: '상담코멘트'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '요약',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildSummaryContainer(vm.summaryData),
                            const SizedBox(height: 20),
                            const Text(
                              '상담 코멘트 작성',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildCommentBox(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BottomOneButton(
                    buttonText: '완료',
                    onButtonTap: () async {
                      // 복지 정책 가져오기
                      final welfareList = await vm.fetchWelfarePolicies();
                      // welfareList is List<WelfarePolicy>

                      // 다음 화면 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WelfareRecommend(welfareData: welfareList),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSummaryContainer(List<Map<String, dynamic>> summaryData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDD8DA).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var summary in summaryData) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFB5457)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                summary['title'],
                style: const TextStyle(
                  color: Color(0xFFFB5457),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            for (var content in summary['content']) ...[
              Text(
                content,
                style: const TextStyle(
                  color: Color(0xFFB3A5A5),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
            ],
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _buildCommentBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        maxLines: 3,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '상담 코멘트를 입력하세요...',
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}
