import 'package:safe_hi/service/user_service.dart';

class UserRepository {
  Future<Map<String, dynamic>> login(String email, String password) {
    return UserService.login(email, password);
  }

  Future<Map<String, dynamic>> fetchUserInfo(int userid) {
    return UserService.fetchUserInfo(userid);
  }
}
