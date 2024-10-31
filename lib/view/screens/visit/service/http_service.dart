import 'dart:convert'; // jsonDecode 사용을 위해 추가
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// 베이스 URL 정의
const String baseUrl = 'http://101.79.9.58:3000/';

// 서버에서 카테고리 정보를 가져오는 메서드
// Future<List<String>> fetchCategoryTitles() async {
//   final response =
//       await http.get(Uri.parse('baseUrl'));

//   if (response.statusCode == 200) {
//     final List<dynamic> data = jsonDecode(response.body);
//     return data
//         .map((item) => item['title'] as String)
//         .toList();
//   } else {
//     throw Exception('Failed to load categories');
//   }
// }

// 카테고리 정보를 가져오는 메서드 테스트용
Future<List<String>> fetchCategoryTitles() async {
  // 테스트용 데이터
  return [
    '동네 마실 예정',
    '무릎 통증으로 10.05(금) 병원 방문예정',
    'TV 프로그램 6시 내고향을 즐겨봄',
    '김장에 관련된 이야기, 감장 예정 있으신지',
  ];
}

// 카테고리 인덱스를 서버로 업로드하는 메서드
Future<void> uploadCategoryIndex(int categoryIndex) async {
  final url = Uri.parse(baseUrl);
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'categoryIndex': categoryIndex + 1}), // 인덱스 + 1 전송
  );

  if (response.statusCode != 200) {
    debugPrint('Failed to upload category: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    throw Exception('Failed to upload category');
  }
}

// 특정 카테고리에 대한 질문 가져오기
// Future<List<String>> fetchQuestions(int categoryIndex) async {
//   final url = Uri.parse('$baseUrl/questions?category=$categoryIndex');

//   try {
//     final response = await http.get(url); // GET 요청

//     // 응답 상태 코드 확인
//     if (response.statusCode == 200) {
//       // JSON 디코딩
//       List<dynamic> jsonResponse = json.decode(response.body);
//       // List<String>로 변환
//       return jsonResponse.map((question) => question.toString()).toList();
//     } else {
//       throw Exception('Failed to load questions'); // 오류 발생 시 예외 처리
//     }
//   } catch (e) {
//     debugPrint('Error fetching questions: $e');
//     return []; // 에러 발생 시 빈 리스트 반환
//   }
// }

// 특정 카테고리에 대한 질문 가져오기 테스트
Future<List<String>> fetchQuestions(int categoryIndex) async {
  // 테스트용 데이터
  return [
    '동네 마실이 어땠는지,',
    '마실 다녀온 후 몸 상태는 괜찮으신지 확인.',
    '다른 지인들과의 대화나 교류가 어땠는지',
    '다음에 또 가보고 싶은 장소나 하고 싶은 활동이 있으신지'
  ];
}
