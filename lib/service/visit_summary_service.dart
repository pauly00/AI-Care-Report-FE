import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:safe_hi/model/visit_summary_model.dart';

class VisitSummaryService {
  static const String baseUrl = 'http://211.188.55.88:3000';

  Future<VisitSummaryResponse> fetchVisitSummary(int reportId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/db/getVisitDetails/$reportId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return VisitSummaryResponse.fromJson(json);
    } else {
      throw Exception('방문 요약 정보를 불러오는 데 실패했습니다.');
    }

    // return VisitSummaryResponse.fromJson({
    //   "reportid": 1,
    //   "items": [
    //     {
    //       "subject": "건강",
    //       "abstract": "소화 관련 불편 지속적 호소",
    //       "detail": "자세한 소화장애 증상 및 시간대별 변화 설명"
    //     },
    //     {
    //       "subject": "경제",
    //       "abstract": "공과금 부담, 경제적 스트레스 존재",
    //       "detail": "전기/수도요금 미납 상태 및 긴급지원 필요사항"
    //     },
    //     {
    //       "subject": "생활",
    //       "abstract": "외출 빈도 급감, 활동량 저하 및 무기력감",
    //       "detail": "최근 외출 기록 없음, 식사 준비도 소홀"
    //     },
    //     {
    //       "subject": "기타",
    //       "abstract": "가족과의 거리감, 사회활동 회피",
    //       "detail": "전화 연락도 거의 없음, 이웃과 접촉도 줄어듦"
    //     }
    //   ]
    // });
  }

  Future<void> uploadVisitSummaryEdit({
    required int reportId,
    required List<VisitSummary> summaries,
  }) async {
    final url = Uri.parse('$baseUrl/db/uploadEditAbstract');

    final body = {
      'reportid': reportId,
      'items': summaries
          .map((summary) => {
                'subject': summary.subject,
                'abstract': summary.abstract,
                'detail': summary.detail,
              })
          .toList(),
    };

    debugPrint('[요약 업로드 요청] ${jsonEncode(body)}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('요약 수정 업로드 실패: ${response.statusCode}');
    }
  }
}
