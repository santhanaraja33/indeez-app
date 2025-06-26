import 'package:music_app/ui/common/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/views/signup/model/signup_model.dart';

import 'dart:convert';

class SharedPreferencesHelper {
  //save OTP
  static Future<bool> saveOTP(String key, String verifyCode) async {
    final prefs = await SharedPreferences.getInstance();
    // Assuming you want to save the OTP with a specific key, e.g., 'otp'
    return await prefs.setString(key, verifyCode);
  }

  //retrieve OTP
  static Future<String?> getOTP(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  //save boolean value from page
  static Future<bool> saveFromPage(String key, bool fromStrPage) async {
    final prefs = await SharedPreferences.getInstance();
    // Assuming you want to save the OTP with a specific key, e.g., 'otp'
    return await prefs.setBool(key, fromStrPage);
  }

  //retrieve boolean value from page
  static Future<bool?> getFromPage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  //save accesstoken
  static Future<bool> saveAccessToken(String key, String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, accessToken);
  }

  //get accesstoken
  static Future<String?> getAccessToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  //signup user api model
  static Future<void> saveUser(SignupUserInfo user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

// 👉 This is the missing method
  static Future<SignupUserInfo?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    if (userJson == null) return null;

    final Map<String, dynamic> userMap = jsonDecode(userJson);
    return SignupUserInfo.fromJson(userMap);
  }

  //save email
  /// Save email to shared preferences
  static Future<void> setEmailId(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ksEmail, email);
  }

  static Future<String?> getEmailId(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  //save user id
  Future<void> saveLoginUserId(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getLoginUserId(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  //clear all preferences
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ksSharedPreferenceOTP);
    await prefs.remove(ksSharedPreferenceEmail);
    await prefs.remove(ksSharedPreferenceFromPage);
    await prefs.remove(ksSharedPreferenceEmailWithOTP);
    await prefs.remove(ksSharedPreferenceFromForgotPasswordPage);
    await prefs.remove(ksSharedPreferenceForgotPasswordWithOTP);
    await prefs.remove(ksSharedPreferenceFromSignupPage);
    await prefs.remove(ksSharedPreferenceSignupWithOTP);
    await prefs.remove(ksEmail);
    await prefs.remove('user');

    await prefs.clear();
  }
}
