import 'package:safe_hi/model/visit_model.dart';
import 'package:safe_hi/service/visit_service.dart';

class VisitRepository {
  /// 오늘 방문 목록
  Future<List<Visit>> getTodayVisits() => VisitService.fetchTodayVisits();

  /// 특정 날짜 방문 목록
  Future<List<Visit>> getVisitsByDate(String date) =>
      VisitService.fetchVisitsByDate(date);

  /// 방문 상세
  Future<Visit> getVisitDetail(int visitId) =>
      VisitService.fetchVisitDetail(visitId);
}
