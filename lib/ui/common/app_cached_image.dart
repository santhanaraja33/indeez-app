import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage(
      {super.key,
      this.borderRadius,
      this.imageHeight,
      this.imageWidth,
      required this.imageURL,
      this.placeholder});

  final BorderRadiusGeometry? borderRadius;
  final double? imageHeight;
  final double? imageWidth;
  final String imageURL;
  final Widget Function(BuildContext, String)? placeholder;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        height: imageHeight,
        width: imageWidth,
        fit: BoxFit.cover,
        imageUrl: imageURL,
        placeholder: placeholder,
        errorWidget: (context, url, error) => const Column(
          children: [
            Icon(Icons.error),
          ],
        ),
      ),
    );
  }
}
