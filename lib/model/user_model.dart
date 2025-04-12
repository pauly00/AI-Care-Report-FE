class UserModel {
  final int userid;
  final String name;
  final String phoneNumber;
  final String email;
  final String birthdate;
  final int gender;
  final int permission;

  UserModel({
    required this.userid,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.permission,
  });

  /// 회원가입 직후 or 전체 사용자 정보 조회 (서버에서 full json이 내려올 때 사용)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userid: json['user_id'] ?? json['userid'] ?? 0,
      name: json['name'] ?? json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      birthdate: json['birthdate'] ?? '',
      gender: json['gender'] ?? 0,
      permission: json['permission'] ?? 0,
    );
  }

  /// 로그인 시에만 내려오는 간단한 유저 응답 처리
  factory UserModel.fromLoginResponse(Map<String, dynamic> json) {
    return UserModel(
      userid: json['userid'] ?? 0,
      name: json['name'] ?? '',
      phoneNumber: '', // 로그인 응답에 없음
      email: json['email'] ?? '',
      birthdate: '', // 없음
      gender: 0, // 없음
      permission: json['role'] == '동행매니저' ? 1 : 0,
    );
  }

  /// 필요하면 toJson도 추가 가능
  Map<String, dynamic> toJson() {
    return {
      "userid": userid,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "birthdate": birthdate,
      "gender": gender,
      "permission": permission,
    };
  }
}
