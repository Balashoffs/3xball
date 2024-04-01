import 'package:flutter/material.dart';
import 'package:three_x_ball/core/theme/app_colors.dart';

extension TextStyleX on TextStyle {
  TextStyle get theme {
    return copyWith(
        color: ThemeMode.dark == ThemeMode.light
            ? AppColorsLight.dark
            : AppColorsDark.light);
  }

  TextStyle get grey {
    return copyWith(
       color: ThemeMode.dark == ThemeMode.light
            ? AppColorsLight.grey
            : AppColorsDark.grey);
  }

  TextStyle get grey10 {
    return copyWith(
       color: ThemeMode.dark == ThemeMode.light
            ? AppColorsLight.grey10
            : AppColorsDark.grey10);
  }

  TextStyle get grey30 {
    return copyWith(
       color: ThemeMode.dark == ThemeMode.light
            ? AppColorsLight.grey30
            : AppColorsDark.grey30);
  }

  TextStyle get grey70 {
    return copyWith(
       color: ThemeMode.dark == ThemeMode.light
            ? AppColorsLight.grey70
            : AppColorsDark.grey70);
  }

  TextStyle get grey100 {
    return copyWith(
       color: ThemeMode.dark == ThemeMode.light
            ? AppColorsLight.grey100
            : AppColorsDark.grey100);
  }

  TextStyle themeOf(BuildContext context) {
    bool brightness = Theme.of(context).brightness == Brightness.light;
    return copyWith(
        color: brightness ? AppColorsLight.dark : AppColorsDark.light);
  }
}
