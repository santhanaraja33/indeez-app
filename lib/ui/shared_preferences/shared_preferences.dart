import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _key = 'selectedFont';

  static Future<void> saveFont(String fontName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, fontName);
  }

  static Future<String> getSavedFont() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'RethinkSans'; // default font
  }
}
