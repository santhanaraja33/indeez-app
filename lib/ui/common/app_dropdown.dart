import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';

class AppDropDown extends StatelessWidget {
  const AppDropDown({
    super.key,
    this.items,
    this.value,
    this.onChanged,
    this.title,
    this.dropDownHint,
    this.titleTextColor,
    this.shadowLightColor,
    this.buttonColor,
    this.bgColor,
  });
  final String? title;
  final String? dropDownHint;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String? value;
  final Color? titleTextColor;
  final Color? shadowLightColor;
  final Color? buttonColor;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: bgColor ?? kcBlack,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            dropDownHint ?? '',
            style: GoogleFonts.lato(
              fontSize: 16,
              color: titleTextColor ?? Theme.of(context).hintColor,
            ),
          ),
          items: items,
          value: value,
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 55,
            width: MediaQuery.of(context).size.width,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
  }
}
