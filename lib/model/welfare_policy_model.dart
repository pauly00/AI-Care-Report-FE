// 복지 정책 정보 (예: 정책명, 조건, 설명 등)
class WelfarePolicy {
  final String policyName;
  final String shortDescription;
  final List<String> detailedConditions;
  final String link;

  WelfarePolicy({
    required this.policyName,
    required this.shortDescription,
    required this.detailedConditions,
    required this.link,
  });

  // /// JSON -> Model 변환 예시
  // factory WelfarePolicy.fromJson(Map<String, dynamic> json) {
  //   return WelfarePolicy(
  //     policyName: json['policy_name'] as String,
  //     shortDescription: json['short_description'] as String,
  //     detailedConditions: List<String>.from(json['detailed_conditions']),
  //     link: json['link'] as String,
  //   );
  // }
}
