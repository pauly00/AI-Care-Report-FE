import 'package:flutter/material.dart';
import 'package:safe_hi/model/visit_model.dart';
import 'package:safe_hi/repository/visit_repository.dart';

class VisitViewModel extends ChangeNotifier {
  final VisitRepository repository;

  VisitViewModel({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Visit> _visits = [];
  List<Visit> get visits => _visits;

  // 오늘 방문자 가져오기
  Future<void> fetchTodayVisits() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await repository.getTodayVisits();
      _visits = data;
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 특정 날짜 방문자 가져오기
  Future<void> fetchVisitsByDate(String date) async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await repository.getVisitsByDate(date);
      _visits = data;
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // visit_view_model.dart
  Future<Visit> fetchVisitDetail(int visitId) async {
    // 단일 Visit 받아오기 (서버 or 더미)
    return await repository.getVisitDetail(visitId);
  }
}
