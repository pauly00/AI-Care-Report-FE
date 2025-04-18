import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/provider/nav/bottom_nav_provider.dart';
import 'package:safe_hi/view/report/widget/report_step_header.dart';
import 'package:safe_hi/view_model/report_view_model.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';
import 'package:safe_hi/main_screen.dart';
import 'package:safe_hi/util/responsive.dart';

class Report6 extends StatelessWidget {
  const Report6({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const DefaultBackAppBar(title: '돌봄 리포트'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: responsive.paddingHorizontal),
                child: Column(
                  children: [
                    const ReportStepHeader(
                      currentStep: 6,
                      totalSteps: 6,
                      stepTitle: '',
                      stepSubtitle: '',
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '돌봄 리포트가 완성되었습니다',
                              style: TextStyle(
                                fontSize: responsive.fontBase,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: responsive.itemSpacing / 1.5),
                            Text(
                              '완성된 파일을 다운받아 확인해보세요!',
                              style: TextStyle(
                                fontSize: responsive.fontSmall,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: responsive.sectionSpacing * 2),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              responsive.buttonHeight * 1.2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFEAEA),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(Icons.share,
                                              size: responsive.iconSize,
                                              color: Colors.black87),
                                          SizedBox(
                                              height:
                                                  responsive.itemSpacing / 2),
                                          Text('공유하기',
                                              style: TextStyle(
                                                  fontSize: responsive.fontBase,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: responsive.itemSpacing),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final reportId = context
                                          .read<ReportViewModel>()
                                          .selectedTarget
                                          ?.reportId;
                                      if (reportId == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text('리포트 ID가 없습니다.')),
                                        );
                                        return;
                                      }

                                      try {
                                        final file = await context
                                            .read<ReportViewModel>()
                                            .downloadReport(reportId);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  '다운로드 완료: ${file.path}')),
                                        );
                                        await OpenFile.open(file.path);
                                      } catch (e) {
                                        debugPrint('❌ 다운로드 실패: $e');
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text('다운로드 실패: $e')),
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              responsive.buttonHeight * 1.2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFEAEA),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(Icons.download_rounded,
                                              size: responsive.iconSize,
                                              color: Colors.black87),
                                          SizedBox(
                                              height:
                                                  responsive.itemSpacing / 2),
                                          Text('다운로드',
                                              style: TextStyle(
                                                  fontSize: responsive.fontBase,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: responsive.paddingHorizontal),
        child: BottomOneButton(
          buttonText: '닫기',
          onButtonTap: () {
            Provider.of<BottomNavProvider>(context, listen: false).setIndex(0);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
