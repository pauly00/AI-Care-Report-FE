import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:safe_hi/util/http_helper.dart';
import 'package:safe_hi/util/login_storage_helper.dart';

class UserService {
  static const String baseUrl = 'http://211.188.55.88:3000';

  /// 로그인 요청 (서버 연동 주석 처리 + 더미 데이터 제공)
  Future<Map<String, dynamic>> login(String email, String password) async {
    debugPrint('[로그인 요청 시작]');
    debugPrint('보낸 데이터: {email: $email, password: $password}');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/db/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      debugPrint('응답 코드: ${response.statusCode}');
      debugPrint('응답 바디: ${utf8.decode(response.bodyBytes)}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('서버 응답: ${response.body}');

        final json = jsonDecode(response.body);
        final token = json['token']; // 서버에서 내려주는 JWT 토큰

        if (json['user'] != null && token != null) {
          // 토큰 저장
          await LoginStorageHelper.saveToken(token);
          return {
            "status": true,
            "msg": json['message'] ?? "로그인 성공",
            "user": json['user'],
          };
        }
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

    // ------ 더미 응답 ------
    // await Future.delayed(const Duration(seconds: 1)); // 테스트용 지연

    // return {
    //   "status": true,
    //   "msg": "테스트용 로그인 성공",
    //   "user": {
    //     "user_id": 4,
    //     "name": "yujin",
    //     "phone_number": "01043830203",
    //     "email": "jenny7732@naver.com",
    //     "birthdate": "2002-02-02T15:00:00.000Z",
    //     "gender": 0,
    //     "permission": 1,
    //   }
    // };
  }

  /// 자동 로그인 시 사용자 정보 요청
  Future<Map<String, dynamic>> fetchUserInfo() async {
    try {
      final headers = await buildAuthHeaders(); // ✅ 토큰 포함 헤더

      final response = await http.get(
        Uri.parse('$baseUrl/db/users'),
        headers: headers,
      );

      debugPrint('[fetchUserInfo] 응답 코드: ${response.statusCode}');
      debugPrint('[fetchUserInfo] 응답 body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json is List && json.isNotEmpty) {
          return json[0]; // ✅ 첫 번째 사용자 정보 반환
        } else {
          throw Exception('사용자 정보가 존재하지 않습니다.');
        }
      } else {
        throw Exception('사용자 정보 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('사용자 정보 요청 중 오류 발생: $e');
    }
  }

  // return {
  //   "user_id": userid,
  //   "name": "yujin",
  //   "phone_number": "01043830203",
  //   "email": "jenny7732@naver.com",
  //   "birthdate": "2002-02-02T15:00:00.000Z",
  //   "gender": 0,
  //   "permission": 1,
  // };
}
