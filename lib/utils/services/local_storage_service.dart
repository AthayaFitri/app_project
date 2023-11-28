// ignore_for_file: unused_element

import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_constants.dart';

enum LoginStatus {
  notSignIn,
  signIn,
}

LoginStatus _loginStatus = LoginStatus.notSignIn;

class LocalStorageService {
  static SharedPreferences? _preferences;

  static Future initializePreference() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setStateLogin(bool state) async =>
      await _preferences?.setBool(AppConstants.loginStateKey, state);

  static bool getStateLogin() =>
      _preferences?.getBool(AppConstants.loginStateKey) ?? false;

  static Future saveUserData(String email, String name, String id) async {
    await _preferences?.setString('email', email);
    await _preferences?.setString('name', name);
    await _preferences?.setString('id', id);
  }

  static String getUserEmail() => _preferences?.getString('email') ?? '';
  static String getUserName() => _preferences?.getString('name') ?? '';
  static String getUserId() => _preferences?.getString('id') ?? '';

  static Future clearUserData() async {
    await _preferences?.remove('email');
    await _preferences?.remove('name');
    await _preferences?.remove('id');
  }

  static Future<void> signOut() async {
    await initializePreference();
    await _preferences?.setBool(AppConstants.loginStateKey, false);
    await _preferences?.remove("email");
    await _preferences?.remove("name");
    await _preferences?.remove("id");
  }
}
