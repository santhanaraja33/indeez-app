import 'package:flutter/material.dart';

class DrawerItem {
  String? title;
  IconData? icon;
  String? imageName;
  bool isExpanded = false;
  bool imageIsExpanded = false;
  String? income;
  String? expenses;
  DrawerItem(
    this.title,
    this.icon,
    this.imageName,
    this.income,
    this.expenses,
  );
}
