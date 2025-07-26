import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:stacked/stacked.dart';

class TypeofuserViewmodel extends BaseViewModel {
  bool showPopup = false;

  List<String> imageList = [
    AppImage.fanImage,
    AppImage.labelImage,
    AppImage.bandImage,
    AppImage.recordStoreImage
  ];
  int currentImageIndex = 0;
  String tvImage = AppImage.whoruImage; // Initially the 'Who R You' screen

  void onTVTap(BuildContext context) {
    if (currentImageIndex < imageList.length) {
      tvImage = imageList[currentImageIndex];
      currentImageIndex++;
      notifyListeners(); // if using Provider
    } else {
      // Navigate to next page
      // Navigator.push(
      //     context,
      // MaterialPageRoute(
      //   builder: (_) => NextScreen(),
      // ));
    }
  }
}
