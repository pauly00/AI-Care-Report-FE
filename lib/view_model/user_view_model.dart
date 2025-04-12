import 'package:flutter/material.dart';
import 'package:safe_hi/model/user_model.dart';
import 'package:safe_hi/repository/user_repository.dart';
import 'package:safe_hi/util/login_storage_helper.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository repository;
  UserModel? user;
  bool get isLoggedIn => user != null;

  UserViewModel({required this.repository});

  Future<Map<String, dynamic>> login(String email, String password,
      {bool saveLogin = false}) async {
    final result = await repository.login(email, password);

    if (result['status'] == true) {
      final userJson = result['user'];
      user = UserModel.fromLoginResponse(userJson);
      notifyListeners();

      if (saveLogin) {
        await LoginStorageHelper.saveLogin(userid: user!.userid);
      }

      return {"success": true, "msg": result['msg']};
    } else {
      return {"success": false, "msg": result['msg']};
    }
  }

  Future<void> tryAutoLogin() async {
    final stored = await LoginStorageHelper.readLogin();
    if (stored['loginStatus'] == 'true' && stored['userid'] != null) {
      final id = int.tryParse(stored['userid']!) ?? -1;
      if (id != -1) {
        final userInfo = await repository.fetchUserInfo(id);
        user = UserModel.fromLoginResponse(userInfo);
        notifyListeners();
      }
    }
  }

  Future<void> logout() async {
    await LoginStorageHelper.clear(); // SecureStorage 초기화
    user = null; // 메모리 정보도 초기화
    notifyListeners();
  }
}
