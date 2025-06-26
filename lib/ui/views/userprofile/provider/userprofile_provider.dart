import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/views/userprofile/model/user_updateprofile_model.dart';
import 'package:music_app/ui/views/userprofile/view_model/userprofile_viewmodel.dart';

class UserprofileProvider extends ChangeNotifier {
  final _profileModel = UserprofileViewModel();
  bool isLoading = false;
  UpdatedAttributes? users;

  Future<void> getUserInfoAPI() async {
    isLoading = true;

    notifyListeners();

    final UpdatedAttributes? usersList = await _profileModel.getUserDetailAPI();
    if (usersList != null) {
      users = usersList;
      safePrint('Users fetched: ${users}');
    } else {
      users = [] as UpdatedAttributes?;
    }

    isLoading = false;
    notifyListeners();
  }
}
