import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';

class AppCommonTextfield extends StatelessWidget {
  const AppCommonTextfield(
      {super.key,
      this.bgColor,
      this.border,
      this.contentPadding,
      this.keyboardType,
      this.label,
      this.obscureText,
      this.onChanged,
      this.onTap,
      this.prefixIcon,
      this.readOnly,
      this.suffixIcon,
      this.onSubmitted,
      this.controller,
      this.maxLength,
      this.hintText});

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? label;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final bool? readOnly;
  final Color? bgColor;
  final InputBorder? border;
  final void Function(String)? onSubmitted;
  final TextEditingController? controller;
  final int? maxLength;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? kcBlack,
      child: TextField(
        maxLength: maxLength,
        buildCounter: (context,
            {required currentLength, required isFocused, required maxLength}) {
          return null;
        },
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        readOnly: readOnly ?? false,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontSize: size_16.sp, color: kcWhite),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: size_14.sp, color: kcWhite),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: border ?? InputBorder.none,
          label: label,
          contentPadding: contentPadding ??
              const EdgeInsets.only(
                left: padding_10,
                top: padding_10,
                bottom: padding_10,
              ),
        ),
        onChanged: onChanged,
        onTap: onTap,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
