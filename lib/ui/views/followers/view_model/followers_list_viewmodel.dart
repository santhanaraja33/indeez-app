import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/views/followers/model/follow_user_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FollowersListViewmodel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  final followersList = [
    FollowUserModel('William', AppImage.user3),
    FollowUserModel('Olivia', AppImage.user4)
  ];
}
