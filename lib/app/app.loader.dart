import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmerLoader extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const CommonShimmerLoader({
    Key? key,
    this.height = 100.0,
    this.width = double.infinity,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.red,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class CommonLoader {
  static void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent dismissing on tap outside
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static void hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(); // close the dialog
  }
}
