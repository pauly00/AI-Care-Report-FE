import 'package:safe_hi/service/summary_service.dart';
import 'package:safe_hi/model/summary_model.dart';

class SummaryRepository {
  final SummaryService _service;

  SummaryRepository(this._service);

  /// 서버에서 대화 요약 데이터를 가져와서 Model로 변환
  Future<List<SummarySection>> fetchSummary() async {
    final rawData = await _service.fetchSummaryData();
    // rawData는 List<Map<String,dynamic>> 형태라고 가정

    // 실제 변환 로직: fromJson() 사용
    // 여기서는 간단히 즉석 변환
    List<SummarySection> results = [];
    for (var item in rawData) {
      // 예시로, item['title'], item['content']가 있다고 가정
      results.add(
        SummarySection(
          title: item['title'] as String,
          content: List<String>.from(item['content']),
        ),
      );
    }
    return results;
  }
}
