import 'package:safe_hi/service/conversation_service.dart';
import 'package:safe_hi/model/conversation_summary_model.dart';

class ConversationRepository {
  final ConversationService _service;

  ConversationRepository(this._service);

  /// 서버에서 대화 요약 데이터를 가져와서 Model로 변환
  Future<List<ConversationSummarySection>> fetchConversationSummary() async {
    final rawData = await _service.fetchConversationSummaryData();
    // rawData는 List<Map<String,dynamic>> 형태라고 가정

    // 실제 변환 로직: fromJson() 사용
    // 여기서는 간단히 즉석 변환
    List<ConversationSummarySection> results = [];
    for (var item in rawData) {
      // 예시로, item['title'], item['content']가 있다고 가정
      results.add(
        ConversationSummarySection(
          title: item['title'] as String,
          content: List<String>.from(item['content']),
        ),
      );
    }
    return results;
  }
}
