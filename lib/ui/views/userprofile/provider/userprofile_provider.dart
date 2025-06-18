import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/views/userprofile/model/userprofile_model.dart';
import 'package:music_app/ui/views/userprofile/view_model/userprofile_viewmodel.dart';

class UserprofileProvider extends ChangeNotifier {
  final _profileModel = UserprofileViewModel();
  bool isLoading = false;
  List<Users>? users;

  Future<void> getUserInfoAPI() async {
    isLoading = true;

    notifyListeners();

    final usersList = await _profileModel.getUserDetailAPI();
    if (usersList != null) {
      users = usersList;
      safePrint('Users fetched: ${users?[0]}');
    } else {
      users = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
