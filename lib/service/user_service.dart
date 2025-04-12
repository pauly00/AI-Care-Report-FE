import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class UserService {
  static const String baseUrl = 'http://211.188.55.88:3000';

  /// 로그인 요청 (서버 연동 주석 처리 + 더미 데이터 제공)
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    debugPrint('[로그인 요청 시작]');
    debugPrint('보낸 데이터: {email: $email, password: $password}');

    // 실제 서버 요청 (주석 처리)
    /*
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/db/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      debugPrint('응답 코드: ${response.statusCode}');
      debugPrint('응답 바디: ${utf8.decode(response.bodyBytes)}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);
        if (json['user'] != null) {
          return {
            "status": true,
            "msg": json['message'] ?? "로그인 성공",
            "user": json['user'],
          };
        } else {
          return {
            "status": false,
            "msg": "유저 정보가 포함되어 있지 않습니다.",
          };
        }
      } else {
        final errorBody = jsonDecode(utf8.decode(response.bodyBytes));
        return {
          "status": false,
          "msg": errorBody['msg'] ?? '로그인 실패',
        };
      }
    } catch (e) {
      return {
        "status": false,
        "msg": "로그인 요청 중 오류가 발생했습니다.\n${e.toString()}",
      };
    }
    */

    // ------ 더미 응답 ------
    await Future.delayed(const Duration(seconds: 1)); // 테스트용 지연

    return {
      "status": true,
      "msg": "테스트용 로그인 성공",
      "user": {
        "user_id": 4,
        "name": "yujin",
        "phone_number": "01043830203",
        "email": "jenny7732@naver.com",
        "birthdate": "2002-02-02T15:00:00.000Z",
        "gender": 0,
        "permission": 1,
      }
    };
  }

  /// 자동 로그인 시 사용자 정보 요청 (더미 응답)
  static Future<Map<String, dynamic>> fetchUserInfo(int userid) async {
    await Future.delayed(const Duration(seconds: 1));

    // 실제 서버 요청 (주석 처리)
    /*
    final response = await http.get(Uri.parse('$baseUrl/db/user/$userid'));
    */

    return {
      "user_id": userid,
      "name": "yujin",
      "phone_number": "01043830203",
      "email": "jenny7732@naver.com",
      "birthdate": "2002-02-02T15:00:00.000Z",
      "gender": 0,
      "permission": 1,
    };
  }
}
