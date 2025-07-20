import 'package:flutter/material.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountSettingsViewmodel extends ChangeNotifier {
  String? selectedStr;
  final List<String> resourceTypes = ['Dark', 'Light'];
  final List<String> appFonts = ['AdelardDemo', 'Rethink-Sans'];

  String? selectedResourceType;
  String? selectedAppFonts;

  final navigationService = locator<NavigationService>();
  List<String> menuItems = [
    'My Followers', // users who are following the logged in user
    'Following Users', //logged in user is following
  ];
  void themeUpdate(String val) {
    selectedResourceType = val;
    notifyListeners();
  }
}
