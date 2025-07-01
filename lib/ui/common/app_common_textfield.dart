import 'package:flutter/material.dart';
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
      this.height,
      this.obscureText,
      this.onChanged,
      this.onTap,
      this.prefixIcon,
      this.readOnly,
      this.suffixIcon,
      this.onSuffixIconTap,
      this.onSubmitted,
      this.controller,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.hintText});

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? label;
  final double? height;
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
  final int? maxLines;
  final int? minLines;
  final VoidCallback? onSuffixIconTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? kcBlack,
      height: height,
      child: TextField(
        buildCounter: (context,
            {required currentLength, required isFocused, required maxLength}) {
          return null;
        },
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.multiline,
        maxLines: (obscureText ?? false) ? 1 : maxLines,
        minLines: (obscureText ?? false) ? 1 : minLines ?? 1,
        obscureText: obscureText ?? false,
        readOnly: readOnly ?? false,
        style: GoogleFonts.lato(color: kcWhite),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.lato(
            fontSize: size_14,
            color: kcWhite,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: onSuffixIconTap != null && suffixIcon != null
              ? GestureDetector(
                  onTap: onSuffixIconTap,
                  child: suffixIcon,
                )
              : suffixIcon,
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
