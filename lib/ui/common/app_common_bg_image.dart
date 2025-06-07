import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_image.dart';

class AppCommonBGImage extends StatelessWidget {
  const AppCommonBGImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImage.appBGImage,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
    );
  }
}
