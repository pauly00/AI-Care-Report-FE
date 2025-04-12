import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginStorageHelper {
  static final _storage = FlutterSecureStorage();

  static Future<void> saveLogin({required int userid}) async {
    await _storage.write(key: 'loginStatus', value: 'true');
    await _storage.write(key: 'userid', value: userid.toString());
  }

  static Future<Map<String, String?>> readLogin() async {
    return {
      'loginStatus': await _storage.read(key: 'loginStatus'),
      'userid': await _storage.read(key: 'userid'),
    };
  }

  static Future<void> clear() async => await _storage.deleteAll();
}
