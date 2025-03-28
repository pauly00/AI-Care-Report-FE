/// 대화 요약의 한 섹션(title, content 배열)
class SummarySection {
  final String title;
  final List<String> content;

  SummarySection({required this.title, required this.content});

  // 추후 JSON -> Model 파싱을 위한 팩토리 메서드
  // /// 실제 서버 JSON 예시:
  // /// {
  // ///   "title": "사회적 고립 상태 평가",
  // ///   "content": ["외로움...", "무기력..."]
  // /// }
  // factory ConversationSummarySection.fromJson(Map<String, dynamic> json) {
  //   return ConversationSummarySection(
  //     title: json['title'] as String,
  //     content: List<String>.from(json['content']),
  //   );
  // }
}
