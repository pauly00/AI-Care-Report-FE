import 'package:flutter/material.dart';
import 'package:safe_hi/view/report/report_2.dart';
import 'package:safe_hi/view/report/widget/report_step_header.dart';
import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            DefaultBackAppBar(title: '돌봄 리포트'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
                              height: 25,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF4F4),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Color(0xFFFB5457)),
                              ),
                              child: TextButton(
                                onPressed: () =>
                                    setState(() => _isEditing = !_isEditing),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit_note_rounded,
                                        size: 16, color: Color(0xFFFB5457)),
                                    SizedBox(width: 4),
                                    Text(
                                      '수정',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFFB5457)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
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
                            const Text('어르신 프로필',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 18)),
                            const SizedBox(height: 8),
                            const Text('이준학(남, 만 77세)',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 4),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 80,
                                    child: Text('주소',
                                        style: TextStyle(fontSize: 16))),
                                Expanded(
                                    child: Text('대전광역시 유성구 OO동',
                                        style: TextStyle(fontSize: 16))),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 80,
                                    child: Text('전화번호',
                                        style: TextStyle(fontSize: 16))),
                                Expanded(
                                    child: Text('010-3889-3501',
                                        style: TextStyle(fontSize: 16))),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text('동행 매니저 프로필',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 18)),
                            const SizedBox(height: 8),
                            const Text('남예준 동행 매니저',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 4),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 80,
                                    child: Text('특이사항',
                                        style: TextStyle(fontSize: 16))),
                                Expanded(
                                    child: Text('대전 지부 OOO동 담당',
                                        style: TextStyle(fontSize: 16))),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text('돌봄 진행 일시',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 18)),
                            const SizedBox(height: 6),
                            _isEditing
                                ? GestureDetector(
                                    onTap: () async {
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            _visitDateTime ?? DateTime.now(),
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
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF9F6F6),
                                        border: Border.all(
                                            color: const Color(0xFFEBE7E7)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        _visitDateTime != null
                                            ? '${_visitDateTime!.toIso8601String().substring(0, 16).replaceAll("T", " ")}'
                                            : 'YYYY-MM-DD HH:MM',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  )
                                : Text(
                                    _visitDateTime != null
                                        ? '${_visitDateTime!.toIso8601String().substring(0, 16).replaceAll("T", " ")}'
                                        : 'YYYY-MM-DD HH:MM',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                            const SizedBox(height: 16),
                            const Text('돌봄 유형',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 18)),
                            const SizedBox(height: 6),
                            _isEditing
                                ? DropdownButton<String>(
                                    value: _careType,
                                    items: const [
                                      DropdownMenuItem(
                                        value: '정기 방문',
                                        child: Text('정기 방문',
                                            style: TextStyle(fontSize: 16)),
                                      ),
                                      DropdownMenuItem(
                                        value: '긴급 방문',
                                        child: Text('긴급 방문',
                                            style: TextStyle(fontSize: 16)),
                                      ),
                                      DropdownMenuItem(
                                        value: '전화 방문',
                                        child: Text('전화 방문',
                                            style: TextStyle(fontSize: 16)),
                                      ),
                                    ],
                                    onChanged: (value) =>
                                        setState(() => _careType = value!),
                                  )
                                : Text(_careType,
                                    style: const TextStyle(fontSize: 16)),
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
        padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0),
        child: BottomOneButton(
          buttonText: _isEditing ? '저장' : '다음',
          onButtonTap: () {
            if (_isEditing) {
              setState(() => _isEditing = false);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Report2()),
              );
            }
          },
        ),
      ),
    );
  }
}
