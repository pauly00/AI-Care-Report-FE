import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safe_hi/model/visit_detail_model.dart';
import 'package:safe_hi/model/visit_model.dart';
import 'package:safe_hi/util/http_helper.dart'; // ✅ 추가

class VisitService {
  static const String baseUrl = 'http://211.188.55.88:3000';

  /// 홈 : 오늘 방문 대상자 리스트
  static Future<List<Visit>> fetchTodayVisits() async {
    final headers = await buildAuthHeaders(); // ✅ 토큰 헤더 추가

    final response = await http.get(
      Uri.parse('$baseUrl/db/getTodayList'),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Visit.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load schedule list');
    }
  }

  /// 특정 날짜 방문 대상자 가져오기
  static Future<List<Visit>> fetchVisitsByDate(String date) async {
    final headers = await buildAuthHeaders(); // ✅ 토큰 헤더 추가

    final response = await http.get(
      Uri.parse('$baseUrl/visits?date=$date'),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Visit.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load visits for $date');
    }
  }

  /// 특정 방문 대상자 기본 정보 조회
  static Future<Visit> fetchVisitDetail(int targetId) async {
    final headers = await buildAuthHeaders(); // ✅ 토큰 헤더 추가

    final response = await http.get(
      Uri.parse('$baseUrl/db/getTargetInfo/$targetId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Visit.fromJson(data);
    } else {
      throw Exception('Failed to load target info');
    }
  }

  /// 특정 방문자의 상세 정보
  Future<VisitDetail> getTargetDetail(int reportId) async {
    final headers = await buildAuthHeaders(); // ✅ 토큰 헤더 추가

    final response = await http.get(
      Uri.parse('$baseUrl/db/getTargetInfo/$reportId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return VisitDetail.fromJson(jsonData);
    } else {
      throw Exception('상세 정보 요청 실패: ${response.statusCode}');
    }
  }
}
