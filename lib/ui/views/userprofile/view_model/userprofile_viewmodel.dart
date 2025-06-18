// ignore_for_file: unused_element

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/userprofile/model/userprofile_model.dart';
import 'package:music_app/ui/views/userprofile/provider/userprofile_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserprofileViewModel extends BaseViewModel implements ChangeNotifier {
  final navigationService = locator<NavigationService>();
  bool isChecked = false;
  bool isPassword = true;
  bool isConfirmPassword = true;
  final paymentModeModel = [
    'Fan',
    'Musician',
    'Label',
    'Venue',
    'Record Store',
  ];
  String? selectedValue;

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      Provider.of<UserprofileProvider>(context!, listen: true).getUserInfoAPI();
    });
  }

  void checkBoxSelected(bool value) {
    isChecked = value;
    rebuildUi();
  }

  void isPasswordShow() {
    isPassword = !isPassword;
    rebuildUi();
  }

  void isConfirmPasswordShow() {
    isConfirmPassword = !isConfirmPassword;
    rebuildUi();
  }

  String? userProfileImage;
  File? file;
  choosePhoto(BuildContext context) async {
    userProfileImage = '';
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result == null) return;
    openFile(PlatformFile file) {
      OpenFile.open(result.files.toString());
    }

    userProfileImage = result.paths.first.toString();
    file = File(result.paths.first.toString());
    rebuildUi();
  }

  File? imageFile;
  String? images;

  BuildContext? get context => null;

  Future pickImage(BuildContext context) async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemp = File(image.path);
      images = imageTemp.toString();
      images = image.name.toString();
      imageFile = imageTemp;
      rebuildUi();
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<List<Users>?> getUserDetailAPI() async {
    final getUserId =
        await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
    debugPrint('User ID: $getUserId');
    final authResponse = await ApiService().getUserInfo(
      endpoint: ApiConstants.baseURL +
          ApiEndpoints.getProfileAPI +
          (getUserId ?? ''), // Replace with actual user ID
    );
    if (authResponse != null) {
      final info = authResponse.users?[0];
      print(info);
      print("User profile image: ${info}");
      if (info != null) {}
    }
    return null;
    // if (signUpResponse.message == "User created") {
    //   Fluttertoast.showToast(msg: "Sign up confirmed!");
    //   final sharedPreferencesHelper = SharedPreferencesHelper();
    //   await sharedPreferencesHelper.saveLoginUserId(
    //       ksLoggedinUserId, signUpResponse.userId ?? '');
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     navigationService.clearStackAndShow(Routes.bottomBarView);
    //   });
    //   CommonLoader.hideLoader(context); // 🔧 Important to hide loader
    // } else {
    //   print("Signup failed.");
    //   Fluttertoast.showToast(msg: "Error: ${signUpResponse.message}");
    //   CommonLoader.hideLoader(context); // 🔧 Important to hide loader
    // }
  }
}
