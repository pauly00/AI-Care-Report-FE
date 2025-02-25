//import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:safe_hi/provider/scenarioId_provider.dart';

// 베이스 URL 정의
const String baseUrl = 'http://211.188.55.88:3000';

// 서버에서 카테고리 정보를 가져오는 메서드
// Future<List<String>> fetchCategoryTitles(BuildContext context) async {
//   final scenarioId =
//       Provider.of<ScenarioIdProvider>(context, listen: false).selectedIndex;

//   final response =
//       await http.get(Uri.parse('$baseUrl/db/checklists/$scenarioId'));

//   if (response.statusCode == 200) {
//     final List<dynamic> data = jsonDecode(response.body);
//     debugPrint(data.toString());

//     // 첫 번째 아이템의 answers 필드 반환
//     return (data[0]['answers'] as List<dynamic>)
//         .map((answer) => answer as String)
//         .toList();
//   } else {
//     throw Exception('Failed to load categories');
//   }
// }

// 카테고리 정보를 가져오는 메서드 테스트용
Future<List<String>> fetchCategoryTitles(BuildContext context) async {
  // 테스트용 데이터
  return [
    '동네 마실 예정',
    '무릎 통증으로 10.05(금) 병원 방문예정',
    'TV 프로그램 6시 내고향을 즐겨봄',
    '김장에 관련된 이야기, 감장 예정 있으신지',
  ];
}

// 카테고리 인덱스를 서버로 업로드하는 메서드
// Future<void> uploadCategoryIndex(int categoryIndex) async {
//   const checklistId = 1; // 업데이트할 checklistId 설정
//   final url = Uri.parse('$baseUrl/db/checklists/$checklistId/answer');

//   // 전송할 데이터 설정
//   final data = {
//     'commentId': 1,
//     'consultantId': 1,
//     'clientId': 1,
//     'selectedAnswer': 'Updated Answer Text', // 필요에 따라 변경
//   };

//   final response = await http.put(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(data),
//   );

//   if (response.statusCode != 200) {
//     debugPrint('Failed to upload category: ${response.statusCode}');
//     debugPrint('Response body: ${response.body}');
//     throw Exception('Failed to upload category');
//   } else {
//     debugPrint('Successfully updated answer');
//   }
// }

// 특정 카테고리에 대한 질문 가져오기
// Future<List<String>> fetchQuestions(
//     BuildContext context, int categoryIndex) async {
//   // scenarioId를 context에서 Provider를 사용해 가져오기
//   final scenarioId =
//       Provider.of<ScenarioIdProvider>(context, listen: false).selectedIndex;

//   // categoryIndex와 scenarioId를 사용하여 URL 생성
//   final url = Uri.parse('$baseUrl/db/questions/$scenarioId/$categoryIndex');

//   try {
//     final response = await http.get(url);

//     // 응답 상태 코드 확인
//     if (response.statusCode == 200) {
//       // JSON 디코딩
//       final jsonResponse = json.decode(response.body);

//       // JSON에서 "questions" 필드를 List<String>으로 변환
//       List<String> questions = List<String>.from(jsonResponse['questions']);

//       return questions; // 질문 목록 반환
//     } else {
//       throw Exception('Failed to load questions'); // 오류 발생 시 예외 처리
//     }
//   } catch (e) {
//     debugPrint('Error fetching questions: $e');
//     return []; // 에러 발생 시 빈 리스트 반환
//   }
// }

// 특정 카테고리에 대한 질문 가져오기 테스트
Future<List<String>> fetchQuestions(
    BuildContext context, int categoryIndex) async {
  // 테스트용 데이터
  return [
    '동네 마실이 어땠는지,',
    '마실 다녀온 후 몸 상태는 괜찮으신지 확인.',
    '다른 지인들과의 대화나 교류가 어땠는지',
    '다음에 또 가보고 싶은 장소나 하고 싶은 활동이 있으신지'
  ];
}

// 대화 요약 데이터 호출 함수
// Future<List<Map<String, dynamic>>> fetchConversationSummary(
//     BuildContext context) async {
//   // scenarioId를 context에서 Provider를 사용해 가져오기
//   final scenarioId =
//       Provider.of<ScenarioIdProvider>(context, listen: false).selectedIndex;

//   // URL에 scenarioId를 사용하여 요청 생성
//   final url =
//       Uri.parse('http://211.188.55.88:3000/db/conversation-summary/$scenarioId');

//   try {
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return List<Map<String, dynamic>>.from(data['conversation_summary']);
//     } else {
//       throw Exception('Failed to load conversation summary');
//     }
//   } catch (e) {
//     debugPrint('Error fetching data: $e');
//     throw Exception('Error fetching conversation summary');
//   }
// }

// 대화 요약 데이터 호출 함수
Future<List<Map<String, dynamic>>> fetchConversationSummary(
    BuildContext context) async {
  return [
    {
      "title": "사회적 고립 상태 평가",
      "content": [
        "사회적 관계: 고객은 사람과의 만남을 꺼리고 있으며, 의욕을 잃고 혼자 있는 시간이 많습니다. 친구나 가족과의 소통이 거의 없고 혼자 지내는 시간이 많습니다.",
        "외로움 및 고립감: 외로움과 무기력함을 느끼고 있으며, 이러한 감정이 계속해서 심화되고 있습니다."
      ]
    },
    {
      "title": "정신적 및 감정적 건강 상태 평가",
      "content": [
        "스트레스: 고객은 개인적 스트레스와 스트레스로 인한 심리적 문제의 신호를 보이고 있습니다.",
        "수면 장애: 잠들기 어렵고 자주 깨어나는 수면 장애를 경험하고 있습니다."
      ]
    },
    {
      "title": "생활 패턴 및 건강 관리 상태 평가",
      "content": [
        "식사 습관: 식사는 주로 인스턴트 음식이나 도시락으로 해결하며, 건강한 식습관을 유지하지 못하고 있습니다.",
        "운동 부족: 운동을 거의 하지 않으며, 체중이 증가하고 건강에 문제가 발생할 위험이 있습니다."
      ]
    },
    {
      "title": "경제적 안정성 평가",
      "content": [
        "경제 상태: 평균적인 월급이지만 스트레스를 유지하고 있으며, 약 100만 원 정도의 여유 자금이 있습니다. 재정적인 계획의 필요성이 추천됩니다."
      ]
    }
  ];
}

// 복지 정책 데이터
// Future<Map<String, dynamic>> fetchWelfarePolicies(BuildContext context) async {
//   // scenarioId를 context에서 Provider를 사용해 가져오기
//   final scenarioId =
//       Provider.of<ScenarioIdProvider>(context, listen: false).selectedIndex;

//   // URL에 scenarioId를 사용하여 요청 생성
//   final response = await http.get(
//       Uri.parse('http://211.188.55.88:3000/db/welfare-policies/$scenarioId'));

//   if (response.statusCode == 200) {
//     // 서버에서 정상적으로 데이터를 받았을 경우
//     return jsonDecode(response.body);
//   } else {
//     throw Exception('Failed to load welfare policies');
//   }
// }

Future<Map<String, dynamic>> fetchWelfarePolicies(BuildContext context) async {
  return {
    "id": 1,
    "age": 25,
    "region": "서울",
    "policy": [
      {
        "policy_name": "노인 의료비 지원",
        "short_description": "무릎통증 및 기타 건강 문제로 병원 방문 필요시 의료비 부담 경감 가능",
        "detailed_conditions": ["외과 관련 진료기록 확인서", "건강보험 납부 확인서"],
        "link": "https://www.naver.com/"
      },
      {
        "policy_name": "테스트 지원 (에너지 바우처)",
        "short_description": "겨울철 무릎 시림과 같은 불편함 해소를 위해 난방비 지원이 유용할 수 있음",
        "detailed_conditions": ["건강보험 맞지 확인서", "전기세 납부 확인서"],
        "link": "https://www.energyv.or.kr/"
      }
    ]
  };
}

//채팅 ui 테스트
Future<List<Map<String, dynamic>>> fetchChatData(BuildContext context) async {
  // 더미 채팅 데이터 반환
  return [
    {"speaker": 2, "text": "안녕하세요. 무엇을 도와드릴까요?"},
    {"speaker": 1, "text": "안녕하세요. 복지 정책에 대해 알고 싶어요."},
    {"speaker": 2, "text": "원하시는 복지 정책의 종류나 지역이 있나요?"},
    {"speaker": 1, "text": "서울 지역에서 제공되는 정책을 알고 싶습니다."},
    {"speaker": 2, "text": "확인해보겠습니다. 잠시만 기다려주세요."},
    {
      "speaker": 2,
      "text": "서울 지역에서 제공되는 복지 정책으로는 '노인 의료비 지원'과 '에너지 바우처'가 있습니다."
    },
    {"speaker": 1, "text": "좋은 정보 감사합니다!"},
    {
      "speaker": 2,
      "text": "서울 지역에서 제공되는 복지 정책으로는 '노인 의료비 지원'과 '에너지 바우처'가 있습니다."
    },
    {"speaker": 1, "text": "좋은 정보 감사합니다!"},
    {
      "speaker": 2,
      "text": "서울 지역에서 제공되는 복지 정책으로는 '노인 의료비 지원'과 '에너지 바우처'가 있습니다."
    },
    {"speaker": 1, "text": "좋은 정보 감사합니다!"},
  ];
}
