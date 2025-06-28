import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/app/app.loader.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:music_app/core/api/api_constants.dart';
import 'package:music_app/core/api/api_endpoints.dart';
import 'package:music_app/core/api/api_services.dart';
import 'package:music_app/shared_preferences/shared_preferences.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/views/userprofile/model/user_updateprofile_model.dart';
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
  UpdatedAttributes actualInfo = UpdatedAttributes();
  bool isChecked = false;
  bool isPassword = true;
  bool isConfirmPassword = true;
  bool acceptPrivacyPolicy = false;
  bool acceptTerms = false;

  String? usertype;
  String? selectedValue;
  String? userProfileImage;
  String? images;

  File? file;
  File? imageFile;

  BuildContext? get context => null;

  final listModeModel = [
    'Fan',
    'Musician',
    'Label',
    'Venue',
    'Record Store',
  ];

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
  Future<UpdatedAttributes?> getUserDetailAPI() async {
    setBusy(true); // Start loader
    try {
      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);

      final UpdatedAttributes? authResponse = await ApiService().getUserInfo(
        endpoint: ApiConstants.baseURL +
            ApiEndpoints.getProfileAPI +
            (getUserId ?? ''),
      );

      if (authResponse != null) {
        actualInfo = authResponse;

        firstNameController.text = authResponse.firstName ?? '';
        lastNameController.text = authResponse.lastName ?? '';
        emailController.text = authResponse.email ?? '';
        phoneController.text = authResponse.phone ?? '';
        zipCodeController.text = authResponse.zipCode ?? '';
        userProfileImage = authResponse.avatarUrl ?? '';
        selectedValue = authResponse.userType ?? '';
        acceptPrivacyPolicy = authResponse.acceptPrivacyPolicy ?? false;
        acceptTerms = authResponse.acceptTerms ?? false;
        rebuildUi();
      }

      return authResponse;
    } catch (e) {
      // Handle error (optional: show toast/snackbar)
      rethrow;
    } finally {
      setBusy(false); // Stop loader
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  //MARK:  User profile update API
  Future<UpdatedAttributes?> userUpdateDetailAPI(BuildContext context) async {
    try {
      CommonLoader.showLoader(context);

      final getUserId =
          await SharedPreferencesHelper.getLoginUserId(ksLoggedinUserId);

      Map<String, dynamic> updatedFields = {};

      if (firstNameController.text.isNotEmpty) {
        if (firstNameController.text.trim() != actualInfo.firstName) {
          updatedFields["firstName"] = firstNameController.text.trim();
        }
      }

      if (lastNameController.text.isNotEmpty) {
        if (lastNameController.text.trim() != actualInfo.lastName) {
          updatedFields["lastName"] = lastNameController.text.trim();
        }
      }

      if (emailController.text.isNotEmpty) {
        if (emailController.text.trim() != actualInfo.email) {
          updatedFields["email"] = emailController.text.trim();
        }
      }

      if (phoneController.text.isNotEmpty) {
        if (phoneController.text.trim() != actualInfo.phone) {
          updatedFields["phone"] = phoneController.text.trim();
        }
      }

      if (zipCodeController.text.isNotEmpty) {
        if (zipCodeController.text.trim() != actualInfo.zipCode) {
          updatedFields["zipCode"] = zipCodeController.text.trim();
        }
      }

      if (selectedValue != null && selectedValue!.isNotEmpty) {
        if (selectedValue != actualInfo.userType) {
          updatedFields["userType"] = selectedValue;
        }
      }
      if (acceptPrivacyPolicy != null &&
          acceptPrivacyPolicy != actualInfo.acceptPrivacyPolicy) {
        updatedFields["acceptPrivacyPolicy"] = acceptPrivacyPolicy;
      }

      if (acceptTerms != null && acceptTerms != actualInfo.acceptTerms) {
        updatedFields["acceptTerms"] = acceptTerms;
      }

      if (actualInfo.avatarUrl !=
          "https://cdn.example.com/avatars/default.png") {
        updatedFields["avatarUrl"] =
            "https://cdn.example.com/avatars/default.png";
      }

      if (actualInfo.bio != "Singer/songwriter") {
        updatedFields["bio"] = "Singer/songwriter";
      }

      final authResponse = await ApiService().updateUserInfo(
        endpoint:
            ApiConstants.baseURL + ApiEndpoints.profileUpdateAPI + getUserId!,
        data: updatedFields,
      );

      safePrint("Profile $authResponse");

      // final authResponse = await ApiService().updateUserInfo(
      //   endpoint:
      //       ApiConstants.baseURL + ApiEndpoints.profileUpdateAPI + getUserId!,
      //   data: {
      //     "firstName": firstNameController.text.trim(),
      //     "lastName": lastNameController.text.trim(),
      //     "email": emailController.text.trim().isNotEmpty
      //         ? emailController.text.trim()
      //         : null,
      //     "phone": phoneController.text.trim(),
      //     "zipCode": zipCodeController.text.trim(),
      //     "userType": selectedValue,
      //     "acceptPrivacyPolicy": acceptPrivacyPolicy,
      //     "acceptTerms": acceptTerms,
      //     "avatarUrl": "https://cdn.example.com/avatars/default.png",
      //     "bio": "Singer/songwriter"
      //   },
      // );
      if (authResponse != null) {
        safePrint("Profile updated successfully.");
        safePrint("Profile ${authResponse}");

        isChecked = false;
        rebuildUi();
        CommonLoader.hideLoader(context);
        Fluttertoast.showToast(msg: "Profile updated successfully");
      } else {
        safePrint("Profile update failed.");
        Fluttertoast.showToast(msg: "Profile update failed. Please try again.");
      }
      return null;
    } catch (e) {
      debugPrint("Update failed: $e");
      // show snackbar or toast
    }
    return null;
  }
}
