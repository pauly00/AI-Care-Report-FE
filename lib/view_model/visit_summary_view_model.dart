// view_model/visit_summary_view_model.dart
import 'package:flutter/material.dart';
import 'package:safe_hi/model/visit_summary_model.dart';
import 'package:safe_hi/repository/visit_summary_repository.dart';

class VisitSummaryViewModel extends ChangeNotifier {
  final VisitSummaryRepository repository;

  VisitSummaryViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<VisitSummary> _summaries = [];
  List<VisitSummary> get summaries => _summaries;

  Future<void> fetchSummary(int reportId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await repository.getSummary(reportId);
      _summaries = response.items;
    } catch (e) {
      debugPrint('[방문 요약 에러] $e');
      _summaries = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
