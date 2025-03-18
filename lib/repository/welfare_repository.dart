import 'package:safe_hi/service/welfare_service.dart';
import 'package:safe_hi/model/welfare_policy_model.dart';

class WelfareRepository {
  final WelfareService _service;

  WelfareRepository(this._service);

  /// 서버에서 복지 정책 정보를 가져와 Model로 변환
  Future<List<WelfarePolicy>> fetchWelfarePolicies() async {
    final rawData = await _service.fetchWelfarePoliciesData();
    // rawData는 Map<String, dynamic> 형태

    // 정책 목록
    final policyList = rawData['policy'] as List<dynamic>;

    // 변환
    List<WelfarePolicy> results = [];
    for (var item in policyList) {
      results.add(
        WelfarePolicy(
          policyName: item['policy_name'] as String,
          shortDescription: item['short_description'] as String,
          detailedConditions: List<String>.from(item['detailed_conditions']),
          link: item['link'] as String,
        ),
      );
    }
    return results;
  }
}
