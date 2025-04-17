import 'package:flutter/material.dart';
import 'package:safe_hi/repository/welfare_repository.dart';
import 'package:safe_hi/service/welfare_service.dart';
import 'package:safe_hi/model/welfare_policy_model.dart';

class VisitPolicyViewModel extends ChangeNotifier {
  bool isLoading = false;

  Future<List<WelfarePolicy>> fetchWelfarePolicies(int reportId) async {
    isLoading = true;
    notifyListeners();

    try {
      final repo = WelfareRepository(WelfareService());
      final policyList = await repo.fetchWelfarePolicies(reportId);
      return policyList;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
