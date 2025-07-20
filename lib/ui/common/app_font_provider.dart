import 'package:flutter/material.dart';
import 'package:music_app/ui/shared_preferences/shared_preferences.dart';

class FontNotifier extends ChangeNotifier {
  String _currentFont = 'RethinkSans';

  String get currentFont => _currentFont;

  void setFont(String font) {
    _currentFont = font;
    SharedPreferencesHelper.saveFont(font);
    notifyListeners();
  }

  Future<void> loadFont() async {
    _currentFont = await SharedPreferencesHelper.getSavedFont();
    notifyListeners();
  }
}
