// ignore_for_file: unused_element

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_app/app/app.locator.dart';
import 'package:open_file/open_file.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserprofileViewModel extends BaseViewModel {
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
}
