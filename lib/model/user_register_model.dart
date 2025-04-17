class UserRegisterModel {
  final String name; // username → name
  final String phoneNumber; // callnum → phoneNumber
  final String email;
  final String birthdate; // birthday → birthdate
  final int gender;
  final int role; // role → role
  final String password;

  UserRegisterModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.role,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "birthdate": birthdate,
      "gender": gender,
      "role": role,
      "password": password,
    };
  }
}
