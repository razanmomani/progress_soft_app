import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  AppSharedPref._privateConstructor();
  static AppSharedPref? _instance;
  static late SharedPreferences prefs;

  static Future<AppSharedPref> getInstance() async {
    _instance ??= AppSharedPref._privateConstructor();
    prefs = await SharedPreferences.getInstance();
    return _instance!;
  }

  Future<void> setSharedPreferences(String key, String? value) async {
    if (value != null && value.isNotEmpty) {
      await prefs.setString(key, value);
    } else {
      await prefs.setString(key, '');
    }
  }

  String getSharedPreferences(String key) {
    String? data = prefs.getString(key);
    if (data != null && data.isNotEmpty) {
      return data;
    } else {
      return data ?? '';
    }
  }

  Future<void> setUserSignInStatus(bool isSignedIn) async {
    await prefs.setBool('isUserLoggedIn', isSignedIn);
  }
}
