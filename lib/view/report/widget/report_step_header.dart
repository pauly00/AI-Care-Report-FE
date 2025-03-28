import 'package:flutter/material.dart';

/// 단계별 프로세스 바 (원/선 구성)
class StepProgressBar extends StatelessWidget {
  final int currentStep; // 현재 스텝 (1부터 시작)
  final int totalSteps; // 전체 스텝 수

  const StepProgressBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps * 2 - 1, (index) {
        // 짝수 index: 원(Circle), 홀수 index: 선(Line)
        if (index % 2 == 0) {
          final stepIndex = index ~/ 2 + 1;
          return _buildStepCircle(stepIndex);
        } else {
          final beforeStep = (index ~/ 2) + 1;
          // beforeStep < currentStep 이면 이미 지나온 선 → 붉은색
          // 아니면 미완료 → 연붉은색(FDD8DA)
          return _buildStepLine(beforeStep < currentStep);
        }
      }),
    );
  }

  Widget _buildStepCircle(int stepIndex) {
    final isCompleted = stepIndex < currentStep; // 완료된 단계
    final isCurrent = stepIndex == currentStep; // 현재 단계
    final isInactive = stepIndex > currentStep; // 미완료 단계

    // 상태에 따라 색상/아이콘을 다르게 설정
    late Color fillColor;
    late Color borderColor;
    late Widget child;

    if (isCompleted) {
      // 완료된 단계: 배경/테두리 붉은색 + 체크 아이콘(흰색)
      fillColor = const Color(0xFFFB5457);
      borderColor = const Color(0xFFFB5457);
      child = const Icon(
        Icons.check,
        size: 16,
        color: Colors.white,
      );
    } else if (isCurrent) {
      // 현재 단계: 배경/테두리 붉은색 + 단계 번호(흰색)
      fillColor = const Color(0xFFFB5457);
      borderColor = const Color(0xFFFB5457);
      child = Text(
        '$stepIndex',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      // 미완료 단계: 배경 흰색 + 테두리/글자 연붉은색(FDD8DA)
      fillColor = Colors.white;
      borderColor = const Color(0xFFFDD8DA);
      child = Text(
        '$stepIndex',
        style: const TextStyle(
          color: Color(0xFFFDD8DA),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Container(
      width: 25,
      height: 25,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  /// 원 사이의 선(Line)
  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? const Color(0xFFFB5457) : const Color(0xFFFDD8DA),
      ),
    );
  }
}

/// 상단 프로세스 바 + 스텝 정보(예: step 3, "변화 추이")를 하나로 묶은 컴포넌트
class ReportStepHeader extends StatelessWidget {
  final int currentStep; // 현재 스텝
  final int totalSteps; // 전체 스텝 수
  final String stepTitle; // 예: "step 3"
  final String stepSubtitle; // 예: "변화 추이"

  const ReportStepHeader({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitle,
    required this.stepSubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 프로세스 바
        StepProgressBar(
          currentStep: currentStep,
          totalSteps: totalSteps,
        ),
        const SizedBox(height: 12),
        // 스텝 타이틀 (예: "step 3")
        Text(
          stepTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFB5457),
          ),
        ),
        const SizedBox(height: 4),
        // 스텝 서브타이틀 (예: "변화 추이")
        Text(
          stepSubtitle,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
