import 'package:flutter/material.dart';
import 'package:safe_hi/repository/welfare_repository.dart';
import 'package:safe_hi/service/welfare_service.dart';
import 'package:safe_hi/model/welfare_policy_model.dart';

class VisitCommentViewModel extends ChangeNotifier {
  bool isLoading = true;
  final List<Map<String, dynamic>> summaryData;

  VisitCommentViewModel({required this.summaryData});

  /// 화면 초기화 로직
  Future<void> initData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (summaryData.isNotEmpty) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<WelfarePolicy>> fetchWelfarePolicies() async {
    final repo = WelfareRepository(WelfareService());
    final policyList = await repo.fetchWelfarePolicies();
    return policyList; // List<WelfarePolicy>
  }
}
