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

  factory WelfarePolicy.fromJson(Map<String, dynamic> json) {
    return WelfarePolicy(
      policyName: json['policy_name'] as String,
      shortDescription: json['short_description'] as String,
      detailedConditions: List<String>.from(json['detailed_conditions']),
      link: json['link'] as String,
    );
  }

  static List<WelfarePolicy> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((e) => WelfarePolicy.fromJson(e)).toList();
  }
}
