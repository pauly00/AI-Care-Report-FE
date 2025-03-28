import 'package:flutter/material.dart';
import 'package:safe_hi/repository/summary_repository.dart';
import 'package:safe_hi/service/summary_service.dart';
import 'package:safe_hi/model/summary_model.dart'; // SummarySection이 정의되어 있다고 가정

class SummaryViewModel extends ChangeNotifier {
  List<SummarySection> summaryData;
  bool isLoading = true;

  final _summaryRepo = SummaryRepository(SummaryService());

  SummaryViewModel({List<SummarySection>? initialSummary})
      : summaryData = initialSummary ?? [];

  Future<void> fetchSummary() async {
    isLoading = true;
    notifyListeners();

    try {
      summaryData = await _summaryRepo.fetchSummary();
    } catch (e) {
      summaryData = [];
      debugPrint('대화 요약 데이터 로드 실패: $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
