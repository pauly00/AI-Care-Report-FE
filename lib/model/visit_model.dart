class Visit {
  final int id;
  final String time;
  final String name;
  final String address;
  final String addressDetails;
  final String phone;

  // 나이, 성별, 기타 필드가 필요하면 여기에 추가
  // final int age;
  // final String gender;

  Visit({
    required this.id,
    required this.time,
    required this.name,
    required this.address,
    required this.addressDetails,
    required this.phone,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      id: json['id'] ?? 1,
      time: json['time'] ?? '10:00 AM',
      name: json['name'] ?? '이유진',
      address: json['address'] ?? '대전 서구 대덕대로 150',
      addressDetails: json['addressDetails'] ?? '경성큰마을아파트 102동 103호',
      phone: json['phone'] ?? '010-0000-0000',
      // age: json['age'],
      // gender: json['gender'],
    );
  }
}
