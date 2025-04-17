// visit_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safe_hi/model/visit_detail_model.dart';
import 'package:safe_hi/model/visit_model.dart';

class VisitService {
  static const String baseUrl = 'http://211.188.55.88:3000';

//홈 : 오늘 방문 대상자 리스트
  static Future<List<Visit>> fetchTodayVisits() async {
    // 실제 서버 요청 (주석 처리)
    final response = await http.get(Uri.parse('$baseUrl/db/getTodayList'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Visit.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load schedule list');
    }

    // 더미 데이터 (서버에서 내려주는 key 형식에 맞게!)
    // final List<Map<String, dynamic>> dummyData = [
//   {
//     "reportid": 2,
//     "reportstatue": 0,
//     "visittime": "2025-04-03 11:00",
//     "targetInfo": {
//       "targetid": 2,
//       "targetname": "김연우",
//       "address1": "대전 서구 대덕대로 150",
//       "address2": "경성 큰마을아파트 102동 103호",
//       "targetcallnum": "010-4567-8901",
//       "gender": 1,
//       "age": 80
//     }
//   },
//   {
//     "reportid": 4,
//     "reportstatue": 0,
//     "visittime": "2025-04-03 14:00",
//     "targetInfo": {
//       "targetid": 1,
//       "targetname": "이유진",
//       "address1": "대전 서구 대덕대로 150",
//       "address2": "경성 큰마을아파트 102동 103호",
//       "targetcallnum": "010-3889-3501",
//       "gender": 1,
//       "age": 77
//     }
//   },
//   {
//     "reportid": 5,
//     "reportstatue": 0,
//     "visittime": "2025-04-03 15:00",
//     "targetInfo": {
//       "targetid": 2,
//       "targetname": "김연우",
//       "address1": "대전 서구 대덕대로 150",
//       "address2": "경성 큰마을아파트 102동 103호",
//       "targetcallnum": "010-4567-8901",
//       "gender": 1,
//       "age": 80
//     }
//   }
// ];

    // return dummyData.map((json) => Visit.fromJson(json)).toList();
  }

  /// 특정 날짜 방문 대상자 가져오기
  static Future<List<Visit>> fetchVisitsByDate(String date) async {
    // 실제 서버 요청 (주석 처리)
    final response = await http.get(Uri.parse('$baseUrl/visits?date=$date'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Visit.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load visits for $date');
    }

    // ---- 더미 데이터 ----
    // final List<Map<String, dynamic>> dummyData = [
    //   {
    //     "id": 4,
    //     "time": "2:00 PM",
    //     "name": "한민우",
    //     "address": "대전 서구 둔산로 123",
    //     "addressDetails": "푸른숲아파트 102동 1202호",
    //     "phone": "010-6666-7777"
    //   },
    //   {
    //     "id": 5,
    //     "time": "3:30 PM",
    //     "name": "이정선",
    //     "address": "대전 동구 용전로 455",
    //     "addressDetails": "용전동아파트 101동 503호",
    //     "phone": "010-9999-8888"
    //   },
    // ];
    // // date에 따라 다른 더미를 리턴해도 되고, 일단 고정
    // return dummyData.map((json) => Visit.fromJson(json)).toList();
  }

  // 특정 방문자 상세정보
  static Future<Visit> fetchVisitDetail(int targetId) async {
    // 실제 요청
    final response =
        await http.get(Uri.parse('$baseUrl/db/getTargetInfo/$targetId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Visit.fromJson(data);
    } else {
      throw Exception('Failed to load target info');
    }

    // 더미 데이터 (서버 응답 형식에 맞게)
    // final Map<String, dynamic> dummyDetail = {
    //   "targetid": targetId,
    //   "targetname": "이유진",
    //   "visittime": "10:00 AM",
    //   "callnum": "010-1010-2020",
    //   "address1": "대전 서구 대덕대로 150",
    //   "address2": "경성 큰마을아파트 102동 103호",
    //   "lastvisit": [
    //     {"date": "2025년 4월 7일", "abstract": "할머니께서는 최근 날짜가 갑자기 쌀쌀해져...."},
    //   ],
    // };

    // return Visit.fromJson(dummyDetail);
  }

  Future<VisitDetail> getTargetDetail(int reportId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/db/getTargetInfo/$reportId'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return VisitDetail.fromJson(jsonData);
    } else {
      throw Exception('상세 정보 요청 실패: ${response.statusCode}');
    }
  }
}
