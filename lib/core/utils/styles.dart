import 'package:flutter/material.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';

import 'colors.dart';

TextStyle textFieldTextStyle(double fontSize) {
  return TextStyle(
    color: brandColorTextFieldBoard,
    fontSize: fontSize,
    fontFamily: 'Gilroy',
  );
}

TextStyle textFieldTextStyleError(double fontSize) {
  return TextStyle(
    color: brandColorBase,
    fontSize: fontSize,
    fontFamily: 'Gilroy',
  );
}

TextStyle textStyle(Color color, double fontSize) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: 'Gilroy',
  );
}

TextStyle textStyleFormat(Color color, double fontSize) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: 'Gilroy',
    letterSpacing: 1.0,
    height: 2.0,
  );
}

TextStyle textStyleBold(Color color, double fontSize) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: 'Gilroy-Bold',
    fontWeight: FontWeight.w500,
  );
}

TextStyle textStyleHeavy(Color color, double fontSize) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontFamily: 'Gilroy-Heavy',
    fontWeight: FontWeight.w500,
  );
}

final TextStyle selected = AT.t.title4.theme;
final TextStyle custom = AT.t.body1.theme;


InputBorder textFieldInputBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: color,
    ),
  );
}

InputDecoration textFieldInputDecoration({
  Widget? suffix,
  Widget? suffixIcon,
  required String labelText,
  required String hintText,
  required VoidCallback onClear,
  required bool enabled,
  String? errorText,
  bool isSelected = false,
}) {
  return InputDecoration(
    suffix: isSelected
        ? GestureDetector(
            onTap: onClear,
            child: Icon(Icons.cancel_outlined, color: brandColorTextFieldBoard))
        : null,
    suffixIcon: isSelected ? null : suffixIcon,
    enabled: enabled,
    suffixIconColor: brandColorTextFieldBoard,
    labelText: labelText,
    labelStyle: textFieldTextStyle(16),
    hintText: hintText,
    hintStyle: textFieldTextStyle(16),
    errorText: errorText,
    errorStyle: textFieldTextStyleError(16),
    errorBorder: textFieldInputBorder(brandColorBase),
    enabledBorder: textFieldInputBorder(brandColorTextFieldBoard),
    focusColor: brandColorTextFieldBoard,
    focusedBorder: textFieldInputBorder(brandColorTextFieldBoard),
    focusedErrorBorder: textFieldInputBorder(brandColorBase),
    border: textFieldInputBorder(brandColorTextFieldBoard),
    disabledBorder: textFieldInputBorder(brandColorTextFieldBoard),
  );
}

InputDecoration dropdownMenuInputDecoration(
    {required bool enabled,
    String? labelText,
    String? hintText,
    String? errorText}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: 3.0,
    ),
    enabled: enabled,
    labelText: labelText,
    hintText: hintText,
    errorText: errorText,
    suffixIconColor: brandColorTextFieldBoard,
    labelStyle: textFieldTextStyle(16),
    hintStyle: textFieldTextStyle(16),
    errorStyle: textFieldTextStyleError(16),
    errorBorder: textFieldInputBorder(brandColorBase),
    enabledBorder: textFieldInputBorder(brandColorTextFieldBoard),
    focusColor: brandColorTextFieldBoard,
    focusedBorder: textFieldInputBorder(brandColorTextFieldBoard),
    focusedErrorBorder: textFieldInputBorder(brandColorBase),
    border: textFieldInputBorder(brandColorTextFieldBoard),
    disabledBorder: textFieldInputBorder(brandColorTextFieldBoard),
  );
}
