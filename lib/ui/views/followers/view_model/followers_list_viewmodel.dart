import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_common_toastmessages.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/followers/model/follow_user_model.dart';
import 'package:music_app/ui/views/followers/model/get_following_list_model.dart';
import 'package:music_app/ui/views/following/model/get_followers_list_model.dart';
import 'package:music_app/ui/views/userprofile/model/user_updateprofile_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FollowersListViewmodel extends BaseViewModel {
  String? userProfileImage;
  bool _isLoading = false;
  late List<Followers>? followingUsersList = [];

  final navigationService = locator<NavigationService>();

  UpdatedAttributes actualInfo = UpdatedAttributes();

  void initializeEvents() {
    followingUsersList = []; // or fetched data
    notifyListeners();
  }

  //Get Post List API
  Future<void> getFollowersListAPI() async {
    final getUserId =
        await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
    _isLoading = true;
    notifyListeners();
    try {
      final String endpoint =
          "${ApiConstants.baseURL}user/$getUserId/followers";

      final GetFollowersListModel? followingList =
          await ApiService().getFollowersListAPI(endpoint: endpoint);
      // CommonLoader.showLoader(context);

      if (followingList != null && followingList.followers == null) {
        // Add to a list if you're collecting all downloads
        followingUsersList = followingList.followers ?? [];
        rebuildUi();
        debugPrint("followers list $followingUsersList");
        // CommonLoader.hideLoader(context);
      } else {
        debugPrint('followers ellse: ${followingList!.followers?.length}');
        followingUsersList = followingList.followers ?? [];
        rebuildUi();
        // CommonLoader.hideLoader(context);
      }
    } catch (e) {
      debugPrint('Error followers : $e');
      // CommonLoader.hideLoader(context);
    }

    _isLoading = false;
    notifyListeners();
  }
}
