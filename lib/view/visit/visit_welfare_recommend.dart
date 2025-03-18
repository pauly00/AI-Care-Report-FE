import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safe_hi/model/welfare_policy_model.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';
import 'package:safe_hi/view/home/home_page.dart';

class WelfareRecommend extends StatefulWidget {
  final List<WelfarePolicy> welfareData;

  const WelfareRecommend({Key? key, required this.welfareData})
      : super(key: key);

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

  // 비동기 함수로 로딩 상태 관리
  Future<void> _loadData() async {
    // 데이터 로드 및 로직 추가 가능
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
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFB5457),
                  ),
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
                            child: Text(
                              'AI 추천 복지 서비스',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '대상자에게 아래 복지 서비스를 추천드립니다.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // widget.welfareData는 List<WelfarePolicy>
                          ..._buildPolicyWidgets(widget.welfareData),
                        ],
                      ),
                    ),
                  ),
                  BottomOneButton(
                    buttonText: '완료',
                    onButtonTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                  ),
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

  /// 하나의 WelfarePolicy 객체로 박스를 만든다
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
                  horizontal: 100,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFB5457),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "상세 정보 확인",
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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
