import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/ui/common/app_colors.dart';

double imageSize = 300;

Widget buildForegroundImage(String foregroundImageUrl, VoidCallback onTap) {
  print('forgroun durl $foregroundImageUrl');
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: imageSize,
      height: imageSize,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(2 / 15),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: foregroundImageUrl,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(color: kcWhite),
          ),
          errorWidget: (context, url, error) => const Center(
            child: FittedBox(
                child: Icon(
              Icons.error,
              size: 100,
              color: kcRed,
            )),
          ),
        ),
      ),
    ),
  );
}

Widget buildBackgroundImage(String backgroundImageUrl, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: imageSize,
      height: imageSize,
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: backgroundImageUrl,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: kcTransparent),
        ),
        errorWidget: (context, url, error) => const Center(
          child: FittedBox(
              child: Icon(
            Icons.error,
            size: 100,
            color: kcWhite,
          )),
        ),
      ),
    ),
  );
}
