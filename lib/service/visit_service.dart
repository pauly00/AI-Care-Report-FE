// visit_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safe_hi/model/visit_model.dart';

class VisitService {
  static const String baseUrl = 'http://211.188.55.88:3000';

  /// 오늘 방문 대상자 가져오기
  static Future<List<Visit>> fetchTodayVisits() async {
    // 실제 서버 요청 (주석 처리)
    // final response = await http.get(Uri.parse('$baseUrl/visits/today'));
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = jsonDecode(response.body);
    //   return data.map((e) => Visit.fromJson(e)).toList();
    // } else {
    //   throw Exception('Failed to load today visits');
    // }

    // ---- 더미 데이터 ----
    final List<Map<String, dynamic>> dummyData = [
      {
        "id": 1,
        "time": "10:00 AM",
        "name": "이유진",
        "address": "대전 서구 대덕대로 150",
        "addressDetails": "경성큰마을아파트 102동 103호",
        "phone": "010-1234-5678"
      },
      {
        "id": 2,
        "time": "11:00 AM",
        "name": "김연우",
        "address": "대전 유성구 테크노 3로 23",
        "addressDetails": "테크노 파크 501호",
        "phone": "010-2222-3333"
      },
      {
        "id": 3,
        "time": "1:00 PM",
        "name": "오민석",
        "address": "대전 중구 계룡로 15",
        "addressDetails": "대전 아파트 202호",
        "phone": "010-4444-5555"
      },
    ];

    // JSON -> Visit 모델로 변환
    return dummyData.map((json) => Visit.fromJson(json)).toList();
  }

  /// 특정 날짜 방문 대상자 가져오기
  static Future<List<Visit>> fetchVisitsByDate(String date) async {
    // 실제 서버 요청 (주석 처리)
    // final response = await http.get(Uri.parse('$baseUrl/visits?date=$date'));
    // if (response.statusCode == 200) {
    //   final List<dynamic> data = jsonDecode(response.body);
    //   return data.map((e) => Visit.fromJson(e)).toList();
    // } else {
    //   throw Exception('Failed to load visits for $date');
    // }

    // ---- 더미 데이터 ----
    final List<Map<String, dynamic>> dummyData = [
      {
        "id": 4,
        "time": "2:00 PM",
        "name": "한민우",
        "address": "대전 서구 둔산로 123",
        "addressDetails": "푸른숲아파트 102동 1202호",
        "phone": "010-6666-7777"
      },
      {
        "id": 5,
        "time": "3:30 PM",
        "name": "이정선",
        "address": "대전 동구 용전로 455",
        "addressDetails": "용전동아파트 101동 503호",
        "phone": "010-9999-8888"
      },
    ];
    // date에 따라 다른 더미를 리턴해도 되고, 일단 고정
    return dummyData.map((json) => Visit.fromJson(json)).toList();
  }

  /// 특정 방문 대상 상세 가져오기
  static Future<Visit> fetchVisitDetail(int visitId) async {
    // 실제 서버 요청 (주석 처리)
    // final response = await http.get(Uri.parse('$baseUrl/visits/$visitId'));
    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   return Visit.fromJson(data);
    // } else {
    //   throw Exception('Failed to load detail for visit $visitId');
    // }

    final Map<String, dynamic> dummyDetail = {
      "id": 1,
      "time": "4:00 PM",
      "name": "박성준",
      "address": "대전 유성구 갑천로 11",
      "addressDetails": "갑천아파트 201동 707호",
      "phone": "010-1010-2020"
    };
    return Visit.fromJson(dummyDetail);
  }
}
