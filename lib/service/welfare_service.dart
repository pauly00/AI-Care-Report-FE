const String baseUrl = 'http://211.188.55.88:3000';

class WelfareService {
  /// 복지 정책 데이터를 서버에서 가져오기
  Future<dynamic> fetchWelfarePoliciesData() async {
    // final response = await http.get(Uri.parse('$baseUrl/welfare-policies'));
    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   return json.decode(response.body);
    // } else {
    //   throw Exception('Failed to load welfare policies');
    // }

    // 더미
    return {
      "id": 1,
      "age": 25,
      "region": "서울",
      "policy": [
        {
          "policy_name": "노인 의료비 지원",
          "short_description": "무릎통증 등 병원 방문 비용 지원",
          "detailed_conditions": ["외과 진료기록", "보험납부 확인서"],
          "link": "https://www.naver.com/",
        },
        {
          "policy_name": "에너지 바우처",
          "short_description": "난방비 지원",
          "detailed_conditions": ["전기세 납부 확인서"],
          "link": "https://www.energyv.or.kr/",
        },
      ],
    };
  }
}
