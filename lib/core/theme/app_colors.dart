import 'package:flutter/material.dart';

class AppColorsLight {

  Color get brandColorBase => const Color.fromRGBO(171, 26, 100, 1);
  Color get brandColorBaseWithOpacity1 => const Color.fromRGBO(171, 26, 100, 0.5);
  Color get brandColorBase2 => const Color.fromRGBO(130, 22, 77, 1);

  Color get brand2ColorBase => const Color.fromRGBO(211, 211, 211, 1);
  Color get userListHeadColor => const Color.fromRGBO(211, 211, 211, 1.0);

  Color get brandColorTextFieldBoard => const Color.fromRGBO(147, 143, 153, 1.0);

  Color get brandColorBaseZero => const Color.fromRGBO(171, 26, 100, 0.0);
  Color get brandColorBaseWithOpacity2 => const Color.fromRGBO(130, 89, 119, 0.2);

  Color get brandColor2BaseBackground => const Color.fromRGBO(55, 60, 64, 1.0);
  Color get managerHeadColor => const Color.fromRGBO(45, 51, 56, 1.0);
  Color get addButtonColor => const Color.fromRGBO(32, 37, 45, 1.0);
  Color get brand3ColorBase => const Color.fromRGBO(32, 37, 45, 1.0);
  Color get brandColorBaseBackground => const Color.fromRGBO(16, 20, 25, 1.0);







  /// primary
  static const Color primaryLight = Color(0xFF19C0B7);
  static const Color primary = Color(0xFF00B9AF);
  static const Color primaryDark = Color(0xFF00A79D);

  ///secondary
  static const Color secondaryLight = Color(0xFFE5F8F7);
  static const Color secondary = Color(0xFFB2EAE7);
  static const Color secondaryDark = Color(0xFF80DCD7);

  ///primary gradient
  static const primaryGradientLight = LinearGradient(
    colors: [Color(0xFF5ABEBA), Color(0xFF4EE3CB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 1],
  );
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF14A29D), Color(0xFF22DCBE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 1],
  );
  static const primaryGradientDark = LinearGradient(
    colors: [Color(0xFF12928D), Color(0xFF1FC6AB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 1],
  );

  ///transparent
  static const Color darkTransparent = Color(0xCC191A1C);
  static const Color lightTransparent = Color(0xB2B7BABE);

  ///gray scale
  static const Color basic = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF191A1C);
  static const Color grey = Color(0xFF53555F);
  static const Color grey100 = Color(0xFF878B93);
  static const Color grey70 = Color(0xFFB7BABE);
  static const Color grey30 = Color(0xFFE7E8E9);
  static const Color grey20 = Color(0xFFEEEEEF);
  static const Color grey10 = Color(0xFFF8F8F8);

  /// attention
  static const Color success = Color(0xFF12B76A);
  static const Color warning = Color(0xFFF79009);
  static const Color danger = Color(0xFFF04438);
}

class AppColorsDark {
  /// primary
  static const Color primaryLight = Color(0xFF19C0B7);
  static const Color primary = Color(0xFF00A79D);
  static const Color primaryDark = Color(0xFF00968D);

  ///secondary
  static const Color secondaryLight = Color(0xFF005D57);
  static const Color secondary = Color(0xFF003835);
  static const Color secondaryDark = Color(0xFF001C1A);

  ///primary gradient
  static const primaryGradientLight = LinearGradient(
    colors: [Color(0xFF14A29D), Color(0xFF22DCBE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 1],
  );
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF12928D), Color(0xFF1FC6AB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 1],
  );
  static const primaryGradientDark = LinearGradient(
    colors: [Color(0xFF0E716E), Color(0xFF189A85)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 1],
  );

  ///transparent
  static const Color darkTransparent = Color(0xCC0C0C0D);
  static const Color lightTransparent = Color(0x6653555F);

  ///gray scale
  static const Color basic = Color(0xFF0C0C0D);
  static const Color light = Color(0xFFF6F7F8);
  static const Color grey = Color(0xFFCFD1D4);
  static const Color grey100 = Color(0xFF9FA3A9);
  static const Color grey70 = Color(0xFF53555F);
  static const Color grey30 = Color(0xFF323339);
  static const Color grey20 = Color(0xFF232428);
  static const Color grey10 = Color(0xFF1B1C1F);

  /// attention
  static const Color success = Color(0xFF6CBC72);
  static const Color warning = Color(0xFFFFA52F);
  static const Color danger = Color(0xFFF3655D);
}
