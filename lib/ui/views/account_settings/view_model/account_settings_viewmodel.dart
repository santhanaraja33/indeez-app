import 'package:flutter/material.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountSettingsViewmodel extends ChangeNotifier {
  String? selectedStr;

  final navigationService = locator<NavigationService>();
  List<String> menuItems = [
    'Following Users', //logged in user is following
    'My Followers', // users who are following the logged in user
  ];
}
