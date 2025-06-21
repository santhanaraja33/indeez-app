import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/app/app.router.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/userprofile/model/user_updateprofile_model.dart';
import 'package:music_app/ui/views/userprofile/model/userprofile_model.dart';
import 'package:music_app/ui/views/userprofile/provider/userprofile_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserprofileViewModel extends BaseViewModel implements ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  final navigationService = locator<NavigationService>();
  bool isChecked = false;
  bool isPassword = true;
  bool isConfirmPassword = true;

  bool acceptPrivacyPolicy = false;
  bool acceptTerms = false;

  String? usertype;
  final listModeModel = [
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

//MARK: Get user info API
  Future<List<Users>?> getUserDetailAPI() async {
    final getUserId =
        await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);
    final authResponse = await ApiService().getUserInfo(
      endpoint: ApiConstants.baseURL +
          ApiEndpoints.getProfileAPI +
          (getUserId ?? ''), // Replace with actual user ID
    );
    if (authResponse != null) {
      final info = authResponse.users?[0];
      firstNameController.text = info!.firstName!;
      lastNameController.text = info.lastName!;
      emailController.text = info.email!;
      phoneController.text = info.phone!;
      zipCodeController.text = info.zipCode!;
      userProfileImage = info.avatarUrl!;
      selectedValue = info.userType!;
      rebuildUi();
    }
    return null;
  }

  //MARK:  User profile update API
  Future<List<UpdatedAttributes>?> userUpdateDetailAPI() async {
    final getUserId =
        await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);

    final authResponse = await ApiService().updateUserInfo(
      endpoint:
          ApiConstants.baseURL + ApiEndpoints.profileUpdateAPI + getUserId!,
      data: {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "zipCode": zipCodeController.text,
        "userType": selectedValue,
        "acceptPrivacyPolicy": acceptPrivacyPolicy,
        "acceptTerms": acceptTerms,
        "avatarUrl": "https://cdn.example.com/avatars/default.png",
        "bio": "Singer/songwriter",
        "userId": getUserId
      },
    );

    if (authResponse != null) {
      safePrint("Profile updated successfully.");
      safePrint(authResponse.message);
      safePrint(authResponse.updatedAttributes?.lastName);
      firstNameController.text = authResponse.updatedAttributes!.firstName!;
      lastNameController.text = authResponse.updatedAttributes!.lastName!;
      emailController.text = authResponse.updatedAttributes!.email!;
      phoneController.text = authResponse.updatedAttributes!.phone!;
      zipCodeController.text = authResponse.updatedAttributes!.zipCode!;
      userProfileImage = authResponse.updatedAttributes!.avatarUrl!;
      selectedValue = authResponse.updatedAttributes!.userType!;
      rebuildUi();
      Fluttertoast.showToast(msg: "Profile updated successfully");
    } else {
      safePrint("Profile update failed.");
      Fluttertoast.showToast(msg: "Login failed. Please try again.");
    }
    return null;
  }
}
