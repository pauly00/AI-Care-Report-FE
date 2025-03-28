import 'package:flutter/material.dart';
import 'package:safe_hi/view_model/visit/visit_check2_view_model.dart';
import 'package:provider/provider.dart';
import 'package:safe_hi/view/visit/visit_comment.dart';

import 'package:safe_hi/widget/appbar/default_back_appbar.dart';
import 'package:safe_hi/widget/button/bottom_one_btn.dart';

class Check2 extends StatelessWidget {
  const Check2({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VisitCheck2ViewModel>(
      create: (_) => VisitCheck2ViewModel(),
      child: const _Check2Body(),
    );
  }
}

// StatefulWidget으로 변환
class _Check2Body extends StatefulWidget {
  const _Check2Body();

  @override
  State<_Check2Body> createState() => _Check2BodyState();
}

class _Check2BodyState extends State<_Check2Body> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<VisitCheck2ViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const DefaultBackAppBar(title: '현장체크'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '상태 변화 관리',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...vm.checklistItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return _buildChecklistItem(context, vm, index, item);
                    }),
                    const SizedBox(height: 10),
                    _buildConditionSection(
                      context,
                      vm,
                      '식사 기능',
                      vm.selectedMealCondition,
                      (val) => vm.setMealCondition(val),
                    ),
                    const SizedBox(height: 10),
                    _buildConditionSection(
                      context,
                      vm,
                      '인지 기능',
                      vm.selectedCognitiveCondition,
                      (val) => vm.setCognitiveCondition(val),
                    ),
                    const SizedBox(height: 10),
                    _buildConditionSection(
                      context,
                      vm,
                      '의사 기능',
                      vm.selectedCommunicationCondition,
                      (val) => vm.setCommunicationCondition(val),
                    ),
                  ],
                ),
              ),
            ),
            BottomOneButton(
              buttonText: '다음',
              isEnabled: vm.isAllChecked,
              onButtonTap: () async {
                final summaryData = await vm.onNextButtonTap();
                if (!mounted) return;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VisitComment(summaryData: summaryData),
                      ),
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // 체크리스트 아이템
  Widget _buildChecklistItem(
    BuildContext context,
    VisitCheck2ViewModel vm,
    int index,
    String item,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
      child: ListTile(
        leading: Checkbox(
          value: vm.isCheckedList[index],
          activeColor: const Color(0xFFFB5457),
          onChanged: (bool? value) {
            vm.toggleChecklistItem(index, value ?? false);
          },
        ),
        title: Text(
          item,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // 상태 변화 체크박스 (식사, 인지, 의사 기능)
  Widget _buildConditionSection(
    BuildContext context,
    VisitCheck2ViewModel vm,
    String title,
    int? selectedCondition,
    Function(int?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            _buildConditionCheckbox('양호', 0, selectedCondition, onChanged),
            _buildConditionCheckbox('보통', 1, selectedCondition, onChanged),
            _buildConditionCheckbox('불량', 2, selectedCondition, onChanged),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionCheckbox(
    String label,
    int index,
    int? selectedCondition,
    Function(int?) onChanged,
  ) {
    return Row(
      children: [
        Checkbox(
          value: selectedCondition == index,
          activeColor: const Color(0xFFFB5457),
          onChanged: (bool? value) {
            onChanged(value! ? index : null);
          },
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
