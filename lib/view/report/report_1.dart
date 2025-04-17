import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/repository/visit_summary_repository.dart';
import 'package:safe_hi/service/visit_summary_service.dart';
import 'package:safe_hi/view/report/report_2.dart';
import 'package:safe_hi/view/report/widget/report_step_header.dart';
import 'package:safe_hi/view_model/report_view_model.dart';
import 'package:safe_hi/view_model/user_view_model.dart';
import 'package:safe_hi/view_model/visit_summary_view_model.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';
import 'package:safe_hi/util/responsive.dart';

class Report1 extends StatefulWidget {
  const Report1({super.key});

  @override
  State<Report1> createState() => _Report1State();
}

class _Report1State extends State<Report1> {
  bool _isEditing = false;
  DateTime? _visitDateTime;
  String _careType = '정기 방문';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final report = Provider.of<ReportViewModel>(context).selectedTarget;
    debugPrint("Report1에서 읽은 selectedTarget: $report");

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const DefaultBackAppBar(title: '돌봄 리포트'),
            Expanded(
              child: report == null
                  ? Center(
                      child: Text(
                        "대상이 없습니다.",
                        style: TextStyle(
                            fontSize: responsive.fontBase,
                            color: Colors.black54),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: responsive.paddingHorizontal),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const ReportStepHeader(
                                  currentStep: 1,
                                  totalSteps: 6,
                                  stepTitle: 'step 1',
                                  stepSubtitle: '기본 정보',
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: responsive.modifyButton,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: responsive.cardSpacing),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF4F4),
                                      borderRadius: BorderRadius.circular(6),
                                      border:
                                          Border.all(color: Color(0xFFFB5457)),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(
                                            () => _isEditing = !_isEditing);
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        transitionBuilder: (child, animation) =>
                                            FadeTransition(
                                                opacity: animation,
                                                child: child),
                                        child: Row(
                                          key: ValueKey(_isEditing),
                                          children: [
                                            Icon(Icons.edit_note_rounded,
                                                size: responsive.iconSize * 0.6,
                                                color: Color(0xFFFB5457)),
                                            SizedBox(width: 4),
                                            Text(
                                              '수정',
                                              style: TextStyle(
                                                  fontSize:
                                                      responsive.fontSmall,
                                                  color: Color(0xFFFB5457)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: responsive.sectionSpacing),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(responsive.cardSpacing),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFFDD8DA),
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('어르신 프로필',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: responsive.fontLarge)),
                                  SizedBox(height: responsive.itemSpacing),
                                  Text(
                                    '${report.targetName}(${report.gender == 1 ? '남' : '여'}, 만 ${report.age}세)',
                                    style: TextStyle(
                                        fontSize: responsive.fontBase),
                                  ),
                                  SizedBox(height: responsive.itemSpacing / 2),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 120,
                                          child: Text('주소',
                                              style: TextStyle(
                                                  fontSize:
                                                      responsive.fontBase))),
                                      Expanded(
                                          child: Text(report.address1,
                                              style: TextStyle(
                                                  fontSize:
                                                      responsive.fontBase))),
                                    ],
                                  ),
                                  SizedBox(height: responsive.itemSpacing / 2),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 120,
                                          child: Text('전화번호',
                                              style: TextStyle(
                                                  fontSize:
                                                      responsive.fontBase))),
                                      Expanded(
                                          child: Text(report.phone,
                                              style: TextStyle(
                                                  fontSize:
                                                      responsive.fontBase))),
                                    ],
                                  ),
                                  SizedBox(height: responsive.itemSpacing),
                                  Text('동행 매니저 프로필',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: responsive.fontLarge)),
                                  SizedBox(height: responsive.itemSpacing),
                                  Text(
                                    '${Provider.of<UserViewModel>(context).user?.name ?? '이름없음'} 동행 매니저',
                                    style: TextStyle(
                                        fontSize: responsive.fontBase),
                                  ),
                                  SizedBox(height: responsive.itemSpacing / 2),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: Text('대전 지부 OOO동 담당',
                                              style: TextStyle(
                                                  fontSize:
                                                      responsive.fontBase))),
                                    ],
                                  ),
                                  SizedBox(height: responsive.itemSpacing),
                                  Text('돌봄 진행 일시',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: responsive.fontLarge)),
                                  SizedBox(height: responsive.itemSpacing / 2),
                                  _isEditing
                                      ? GestureDetector(
                                          onTap: () async {
                                            final picked = await showDatePicker(
                                              context: context,
                                              initialDate: _visitDateTime ??
                                                  DateTime.tryParse(report
                                                      .visitTime
                                                      .replaceAll(" ", "T")) ??
                                                  DateTime.now(),
                                              firstDate: DateTime(2023),
                                              lastDate: DateTime(2100),
                                            );
                                            if (picked != null) {
                                              final time = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              );
                                              if (time != null) {
                                                setState(() {
                                                  _visitDateTime = DateTime(
                                                    picked.year,
                                                    picked.month,
                                                    picked.day,
                                                    time.hour,
                                                    time.minute,
                                                  );
                                                });
                                                context
                                                    .read<ReportViewModel>()
                                                    .updateVisitTime(
                                                        _visitDateTime!);
                                              }
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                responsive.itemSpacing),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF9F6F6),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFFEBE7E7)),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              _visitDateTime != null
                                                  ? '${_visitDateTime!.toIso8601String().substring(0, 16).replaceAll("T", " ")}'
                                                  : report.visitTime,
                                              style: TextStyle(
                                                  fontSize:
                                                      responsive.fontBase),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          _visitDateTime != null
                                              ? '${_visitDateTime!.toIso8601String().substring(0, 16).replaceAll("T", " ")}'
                                              : report.visitTime,
                                          style: TextStyle(
                                              fontSize: responsive.fontBase),
                                        ),
                                  SizedBox(height: responsive.itemSpacing),
                                  Text('돌봄 유형',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: responsive.fontLarge)),
                                  SizedBox(height: responsive.itemSpacing / 2),
                                  _isEditing
                                      ? DropdownButton<String>(
                                          value: _careType,
                                          items: [
                                            DropdownMenuItem(
                                              value: '정기 방문',
                                              child: Text('정기 방문',
                                                  style: TextStyle(
                                                      fontSize:
                                                          responsive.fontBase)),
                                            ),
                                            DropdownMenuItem(
                                              value: '긴급 방문',
                                              child: Text('긴급 방문',
                                                  style: TextStyle(
                                                      fontSize:
                                                          responsive.fontBase)),
                                            ),
                                            DropdownMenuItem(
                                              value: '전화 방문',
                                              child: Text('전화 방문',
                                                  style: TextStyle(
                                                      fontSize:
                                                          responsive.fontBase)),
                                            ),
                                            DropdownMenuItem(
                                              value: '기타',
                                              child: Text('기타',
                                                  style: TextStyle(
                                                      fontSize:
                                                          responsive.fontBase)),
                                            ),
                                          ],
                                          onChanged: (value) => setState(
                                              () => _careType = value!),
                                        )
                                      : Text(_careType,
                                          style: TextStyle(
                                              fontSize: responsive.fontBase)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: responsive.paddingHorizontal),
        child: BottomOneButton(
          buttonText: _isEditing ? '저장' : '다음',
          onButtonTap: () async {
            if (_isEditing) {
              setState(() => _isEditing = false);
              return;
            }

            final reportVM = context.read<ReportViewModel>();
            final userVM = context.read<UserViewModel>();
            final user = userVM.user;
            final target = reportVM.selectedTarget;

            if (user == null || target == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('유저 정보 또는 대상자가 없습니다.')),
              );
              return;
            }

            try {
              debugPrint(
                  '[STEP1 업로드 요청] target: ${target.targetName}, user: ${user.name}, visitType: $_careType');

              final result = await reportVM.submitReportStep1(
                visitType: _careType,
                user: user,
              );

              debugPrint('[STEP1 업로드 결과] $result');

              if (result['status'] == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => VisitSummaryViewModel(
                        repository: VisitSummaryRepository(
                            service: VisitSummaryService()),
                      )..fetchSummary(report!.reportId),
                      child: const Report2(),
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result['msg'] ?? '업로드 실패')),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('업로드 중 오류 발생: $e')),
              );
            }
          },
        ),
      ),
    );
  }
}
