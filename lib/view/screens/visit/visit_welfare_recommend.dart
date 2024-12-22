import 'package:flutter/material.dart';
import 'package:safe_hi/view/screens/home/home_page.dart';
import 'package:safe_hi/view/widgets/base/top_menubar.dart';
import 'package:safe_hi/view/widgets/btn/bottom_one_btn.dart';
import 'package:url_launcher/url_launcher.dart';

class WelfareRecommend extends StatefulWidget {
  final Map<String, dynamic> welfareData;

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
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFB5457)),
                ),
              )
            : Column(
                children: [
                  TopMenubar(
                    title: 'AI 복지정책',
                    showBackButton: true,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'AI 추천 복지 서비스',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '대상자에게 아래 복지 서비스를 추천드립니다.',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ..._buildPolicyWidgets(
                                widget.welfareData['policy'] ?? []),
                          ],
                        ),
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

  List<Widget> _buildPolicyWidgets(List<dynamic> policies) {
    return policies.map((policy) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: _buildWelfareBox(
          policyName: policy['policy_name'] ?? '정책 이름 없음',
          shortDescription: policy['short_description'] ?? '설명 없음',
          detailedConditions: policy['detailed_conditions'] ?? [],
          link: policy['link'] ?? '',
        ),
      );
    }).toList();
  }

  Widget _buildWelfareBox({
    required String policyName,
    required String shortDescription,
    required List<dynamic> detailedConditions,
    required String link,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
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
          Text(
            policyName,
            style: const TextStyle(
              color: Color(0xFFFB5457),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            shortDescription,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '세부정보',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '- 신청을 위해선 아래의 것들이 필요합니다.',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 5),
          for (var condition in detailedConditions)
            Text(
              ' > $condition',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          const SizedBox(height: 10),
          Center(
            child: InkWell(
              onTap: () => _launchURL(link),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 100),
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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
