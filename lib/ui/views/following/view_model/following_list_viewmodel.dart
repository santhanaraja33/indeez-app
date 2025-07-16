import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/followers/model/follow_user_model.dart';
import 'package:music_app/ui/views/followers/model/get_following_list_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FollowingListViewmodel extends BaseViewModel {
  bool _isLoading = false;
  late List<Following>? followUsersList = [];
  final navigationService = locator<NavigationService>();

  //Get Post List API
  Future<void> getFollowingListAPI() async {
    final getUserId =
        await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
    _isLoading = true;
    notifyListeners();
    try {
      final String endpoint =
          "${ApiConstants.baseURL}${ApiEndpoints.getFollowersFollowingList}$getUserId/following";

      final GetFollowingListModel? followingList =
          await ApiService().getFollowingListAPI(endpoint: endpoint);
      // CommonLoader.showLoader(context);

      if (followingList != null && followingList.following == null) {
        // Add to a list if you're collecting all downloads
        followUsersList = followingList.following ?? [];
        rebuildUi();
        debugPrint("followingList $followUsersList");
        // CommonLoader.hideLoader(context);
      } else {
        debugPrint('followingList ellse: ${followingList!.following?.length}');
        followUsersList = followingList.following ?? [];
        rebuildUi();
        // CommonLoader.hideLoader(context);
      }
    } catch (e) {
      debugPrint('Error followingList : $e');
      // CommonLoader.hideLoader(context);
    }

    _isLoading = false;
    notifyListeners();
  }

  //MARK: Get user info API
  Future<FollowUserModel?> toFollowAUserAPI(
      String followersId, BuildContext context) async {
    setBusy(true);
    final getUserId =
        await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);

    const String endpoint =
        "${ApiConstants.baseURL}${ApiEndpoints.getUnfollowUseList}";

    final FollowUserModel? toFollowUser =
        await ApiService().toFollowAUserAPI(endpoint: endpoint, data: {
      "followerId":
          followersId, // logged in user who wants to follow a other user
      "followeeId": getUserId
    });
    CommonLoader.showLoader(context);
    await Future.delayed(const Duration(seconds: 1));
    // ignore: unrelated_type_equality_checks
    if (toFollowUser!.message == ksUserFollowedSuccessfully) {
      CommonLoader.hideLoader(context);
      debugPrint("User followed successfully");
    } else {
      CommonLoader.hideLoader(context);
      debugPrint("User not followed");
      // const AppCommonToastmessages()
      //     .showAppSnackBar(context, toFollowUser.message!);
    }
    getFollowingListAPI();
    // rebuildUi();
    setBusy(false);
    // CommonLoader.hideLoader(context!);
    return null;
  }
}
