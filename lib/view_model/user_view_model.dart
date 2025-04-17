import 'package:flutter/material.dart';
import 'package:safe_hi/model/user_model.dart';
import 'package:safe_hi/service/user_service.dart';
import 'package:safe_hi/util/login_storage_helper.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _service;
  UserModel? _user;
  bool isLoading = false;

  UserViewModel(this._service);

  UserModel? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<void> loadUser(int userId) async {
    isLoading = true;
    notifyListeners();
    try {
      final userInfo = await _service.fetchUserInfo(userId);
      _user = UserModel.fromJson(userInfo);
    } catch (e) {
      debugPrint('User fetch error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> tryAutoLogin() async {
    final stored = await LoginStorageHelper.readLogin();
    final loginStatus = stored['loginStatus'];
    final userIdString = stored['userid'];
    final id = int.tryParse(userIdString ?? '') ?? 0;

    if (loginStatus == 'true' && id > 0) {
      try {
        final userInfo = await _service.fetchUserInfo(id);
        _user = UserModel.fromJson(userInfo);
        notifyListeners();
      } catch (e) {
        debugPrint('[자동 로그인 실패] $e');
        await LoginStorageHelper.clear();
      }
    } else {
      debugPrint('[자동 로그인 조건 미달] loginStatus=$loginStatus / id=$id');
    }
  }

  Future<void> saveLogin(int userId) async {
    await LoginStorageHelper.saveLogin(userid: userId);
  }

  Future<Map<String, dynamic>> login(String email, String password,
      {bool saveLogin = false}) async {
    try {
      final loginResponse = await _service.login(email, password);
      final userInfo = loginResponse['user'];
      debugPrint("로그인 응답 userInfo: $userInfo");

      _user = UserModel.fromJson(userInfo);

      if (saveLogin) {
        await this.saveLogin(_user!.userId);
      }

      notifyListeners();

      return {
        'success': true,
        'msg': '로그인 성공',
      };
    } catch (e) {
      return {
        'success': false,
        'msg': '로그인 실패: $e',
      };
    }
  }

  Future<void> logout() async {
    await LoginStorageHelper.clear();
    _user = null;
    notifyListeners();
  }
}
