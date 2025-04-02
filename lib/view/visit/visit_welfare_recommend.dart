import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/provider/nav/bottom_nav_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safe_hi/model/welfare_policy_model.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';
import 'package:safe_hi/main_screen.dart';

class WelfareRecommend extends StatefulWidget {
  final List<WelfarePolicy> welfareData;

  const WelfareRecommend({super.key, required this.welfareData});

  @override
  State<WelfareRecommend> createState() => _WelfareRecommendState();
}

class _WelfareRecommendState extends State<WelfareRecommend> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (widget.welfareData.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFFB5457),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '잠시만 기다려주세요.\n어르신께 필요한 정보를 찾고 있습니다!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  const DefaultBackAppBar(title: 'AI 복지정책'),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'AI 추천 복지 서비스',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '어르신께 맞는 복지 서비스를 찾아봤어요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ..._buildPolicyWidgets(widget.welfareData),
                        ],
                      ),
                    ),
                  ),
                  BottomOneButton(
                      buttonText: '완료',
                      onButtonTap: () {
                        // BottomNavProvider의 인덱스 설정
                        Provider.of<BottomNavProvider>(context, listen: false)
                            .setIndex(0);

                        // MainScreen으로 이동하면서 기존 스택 제거
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                          (route) => false,
                        );
                      }),
                ],
              ),
      ),
    );
  }

  List<Widget> _buildPolicyWidgets(List<WelfarePolicy> policyList) {
    return policyList.map((policy) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _buildWelfareBox(policy),
      );
    }).toList();
  }

  /// 하나의 WelfarePolicy 객체로 박스를 만든다.
  Widget _buildWelfareBox(WelfarePolicy policy) {
    return Container(
      padding: const EdgeInsets.all(15),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 정책명
          Text(
            policy.policyName,
            style: const TextStyle(
              color: Color(0xFFFB5457),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          // 요약 설명
          Text(
            policy.shortDescription,
            style: const TextStyle(color: Colors.black, fontSize: 13),
          ),
          const SizedBox(height: 10),
          const Text(
            '세부정보',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            '- 신청을 위해선 아래의 것들이 필요합니다.',
            style: TextStyle(color: Colors.black, fontSize: 11),
          ),
          const SizedBox(height: 5),
          // detailedConditions
          for (var condition in policy.detailedConditions)
            Text(
              ' > $condition',
              style: const TextStyle(color: Colors.black, fontSize: 13),
            ),
          const SizedBox(height: 10),
          // 링크 버튼
          Center(
            child: InkWell(
              onTap: () => _launchURL(policy.link),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 110,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFB5457),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "자세히 보기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// URL 링크 열기
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
