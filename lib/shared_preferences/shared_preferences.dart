import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<bool> saveOTP(String key, String verifyCode) async {
    final prefs = await SharedPreferences.getInstance();
    // Assuming you want to save the OTP with a specific key, e.g., 'otp'
    return await prefs.setString(key, verifyCode);
  }

  static Future<String?> getOTP(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> saveFromPage(String key, bool fromStrPage) async {
    final prefs = await SharedPreferences.getInstance();
    // Assuming you want to save the OTP with a specific key, e.g., 'otp'
    return await prefs.setBool(key, fromStrPage);
  }

  static Future<bool?> getFromPage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
