import 'package:flutter/material.dart';
import 'package:safe_hi/repository/welfare_repository.dart';
import 'package:safe_hi/service/welfare_service.dart';
import 'package:safe_hi/model/welfare_policy_model.dart';

class VisitPolicyViewModel extends ChangeNotifier {
  // isLoading이 꼭 필요하다면 사용, 아니면 제거 가능
  bool isLoading = false;

  Future<List<WelfarePolicy>> fetchWelfarePolicies() async {
    final repo = WelfareRepository(WelfareService());
    final policyList = await repo.fetchWelfarePolicies();
    return policyList; // List<WelfarePolicy>
  }
}
