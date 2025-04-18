import 'package:safe_hi/model/report_model.dart';
import 'package:safe_hi/model/user_model.dart';
import 'package:safe_hi/service/report_service.dart';

class ReportRepository {
  final ReportService service;

  ReportRepository({required this.service});

  Future<List<ReportTarget>> getReportTargets() => service.fetchReportTargets();

  Future<Map<String, dynamic>> uploadDefaultReport({
    required ReportTarget target,
    required UserModel user,
    required String visitType,
    required String endTime,
  }) {
    return service.uploadDefaultReport(
      target: target,
      user: user,
      visitType: visitType,
      endTime: endTime,
    );
  }

  Future<void> uploadVisitDetail({
    required int reportId,
    required String detail,
  }) {
    return service.uploadVisitDetail(reportId: reportId, detail: detail);
  }
}
