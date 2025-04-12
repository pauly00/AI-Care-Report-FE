import 'package:flutter/material.dart';
import 'package:safe_hi/util/responsive.dart';
import 'package:safe_hi/view/visit/widget/drop_box.dart';
import 'package:safe_hi/view_model/visit/visit_list_view_model.dart';
import 'package:safe_hi/model/visit_model.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_two_btn.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safe_hi/view/visit/visit_checklist_ready.dart';

class VisitDetailPage extends StatefulWidget {
  final int visitId;
  final VisitViewModel viewModel;

  const VisitDetailPage({
    Key? key,
    required this.visitId,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<VisitDetailPage> createState() => _VisitDetailPageState();
}

class _VisitDetailPageState extends State<VisitDetailPage> {
  Visit? _visit;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // 첫 빌드 완료 후 서버 호출
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDetail();
    });
  }

  Future<void> _fetchDetail() async {
    setState(() => _isLoading = true);
    try {
      final detail = await widget.viewModel.fetchVisitDetail(widget.visitId);
      setState(() {
        _visit = detail;
      });
    } catch (e) {
      debugPrint('상세 조회 실패: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      debugPrint('전화 연결을 할 수 없습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 공통 AppBar
                    const DefaultBackAppBar(title: '상세 보기'),
                    SizedBox(height: responsive.sectionSpacing),

                    // ✅ visit가 없으면: 본문에 "상세 정보가 없습니다." 표시
                    if (_visit == null)
                      Padding(
                        padding:
                            EdgeInsets.only(top: responsive.screenHeight * 0.2),
                        child: const Center(child: Text('상세 정보가 없습니다.')),
                      )
                    else
                      // visit가 존재하면 원래의 상세 UI
                      _buildDetailContent(responsive),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: _visit == null ? null : _buildBottomNav(responsive),
    );
  }

  Widget _buildDetailContent(Responsive responsive) {
    final visit = _visit!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.paddingHorizontal),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                visit.name,
                style: TextStyle(
                  fontSize: responsive.fontLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: responsive.sectionSpacing),
            ],
          ),
          SizedBox(height: responsive.sectionSpacing),

          Container(
            padding: EdgeInsets.all(responsive.sectionSpacing),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '주소',
                  style: TextStyle(
                    fontSize: responsive.fontBase,
                    color: Color(0xFFB3A5A5),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(visit.address,
                        style: TextStyle(
                          fontSize: responsive.fontBase,
                        )),
                    Text(visit.addressDetails,
                        style: TextStyle(
                          fontSize: responsive.fontBase,
                        )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: responsive.sectionSpacing),

          // 전화번호
          Container(
            padding: EdgeInsets.all(responsive.sectionSpacing),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFDD8DA).withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '전화번호',
                  style: TextStyle(
                    fontSize: responsive.fontBase,
                    color: Color(0xFFB3A5A5),
                  ),
                ),
                Text(visit.phone,
                    style: TextStyle(
                      fontSize: responsive.fontBase,
                    )),
                InkWell(
                  onTap: () => _makePhoneCall(visit.phone),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.phone, color: Colors.redAccent),
                      SizedBox(height: 4),
                      Text(
                        '전화걸기',
                        style: TextStyle(
                          fontSize: responsive.fontSmall,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: responsive.sectionSpacing),

          Column(
            children: [
              DropdownCard(
                  title: '이전 방문',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2025년 4월 7일:',
                        style: TextStyle(
                            fontSize: responsive.fontBase,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '할머니께서는 최근 날씨가 갑자기 쌀쌀해져 무릎이 시리다고 하셨습니다. 온찜질을 제안드렸고, 찜질팩을 다음 방문 때 가져오기로 했습니다. 최근에는 박 여사님과 공원과 시장에 다녀오셨고, 고구마를 사서 구워 드셨으나 혼자 하는 게 재미없다고 하셨습니다. 다음번 고구마 구울 때 같이 하기로 했습니다. 또한, 내 고향 친구라는 TV 프로그램을 즐겨보고 계시며, 옛날 이야기와 시골 풍경이 마음을 편안하게 해준다고 하셨습니다. 예전 고구마를 함께 구워 먹던 추억을 그리워하셨습니다.',
                        style: TextStyle(
                          fontSize: responsive.fontSmall,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(Responsive responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.paddingHorizontal),
      child: BottomTwoButton(
        buttonText1: '방문일자수정',
        buttonText2: '상담시작',
        onButtonTap1: () {
          // ...
        },
        onButtonTap2: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CheckListReady()),
          );
        },
      ),
    );
  }
}
