import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_strings.dart';

class AppDropDown extends StatelessWidget {
  const AppDropDown(
      {super.key,
      this.items,
      this.value,
      this.onChanged,
      this.title,
      this.dropDownHint,
      this.titleTextColor,
      this.shadowLightColor,
      this.buttonColor,
      this.bgColor,
      this.selectedTextColor,
      this.border,
      this.borderRadius});
  final String? title;
  final String? dropDownHint;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String? value;
  final Color? titleTextColor;
  final Color? shadowLightColor;
  final Color? buttonColor;
  final Color? bgColor;
  final Color? selectedTextColor;
  final Border? border;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        border: border ?? Border.all(color: Colors.transparent, width: 1),
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
          selectedItemBuilder: (context) {
            return items!.map((item) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.value!,
                  style: GoogleFonts.lato(
                    fontSize: size_14,
                    color: selectedTextColor ?? kcWhite,
                  ),
                ),
              );
            }).toList();
          },
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            iconEnabledColor: Colors.white, // ✅ Change icon color here
            iconDisabledColor: Colors.grey,
          ),
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
