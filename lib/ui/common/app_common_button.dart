import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';

class AppCommonButton extends StatelessWidget {
  const AppCommonButton(
      {super.key,
      this.buttonName,
      this.height,
      this.width,
      this.onPressed,
      this.backgroundColor,
      this.color});
  final String? buttonName;
  final double? height;
  final double? width;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? kcButtonColr,
        ),
        onPressed: onPressed,
        child: Text(
          buttonName ?? '',
          style: GoogleFonts.lato(
            fontSize: size_16,
            fontWeight: FontWeight.bold,
            color: color ?? kcBlack,
          ),
        ),
      ),
    );
  }
}
