import 'package:music_app/app/app.locator.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/views/followers/model/follow_user_model.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FollowingListModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  final followersList = [
    FollowUserModel('Mithran', AppImage.user1),
    FollowUserModel('Hosanna', AppImage.user2)
  ];
}
