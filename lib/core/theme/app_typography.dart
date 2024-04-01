import 'package:flutter/material.dart';
import 'package:three_x_ball/core/service/platform_service.dart';

typedef AT = AppTypographyFlexible;

class AppTypographyFlexible {
  static AppTypography get t {
    if (PlatformService.isMobile) {
      return AppTypographyMobile();
    }
    return AppTypographyTablet();
  }
}

abstract class AppTypography {
  static const interBold = 'Gilroy-Bold';
  static const interSemiBold = 'Gilroy-Semibold';
  static const interMedium = 'Gilroy-Medium';
  static const interRegular = 'Gilroy-Regular';

  ///titles
  TextStyle get title1 => const TextStyle();
  TextStyle get title2 => const TextStyle();
  TextStyle get title3 => const TextStyle();
  TextStyle get title4 => const TextStyle();

  ///buttons
  TextStyle get button => const TextStyle();
  TextStyle get button2 => const TextStyle();

  ///heads
  TextStyle get headline => const TextStyle();
  TextStyle get subhead => const TextStyle();

  ///bodies
  TextStyle get body1 => const TextStyle();
  TextStyle get body2 => const TextStyle();

  ///captions
  TextStyle get caption => const TextStyle();
}

typedef ATM = AppTypographyMobile;

class AppTypographyMobile extends AppTypography {
  static final AppTypographyMobile _mobile = AppTypographyMobile._internal();

  factory AppTypographyMobile(){
    return _mobile;
  }

  AppTypographyMobile._internal();

  @override
  TextStyle get title1 => const TextStyle(
        fontFamily: AppTypography.interBold,
        fontSize: 26,
        height: 1.23,
      );
  @override
  final TextStyle title2 = const TextStyle(
    fontFamily: AppTypography.interBold,
    fontSize: 20,
    height: 1.2,
  );
  @override
  final TextStyle title3 = const TextStyle(
    fontFamily: AppTypography.interBold,
    fontSize: 20,
    height: 1.2,
  );
  @override
  final TextStyle title4 = const TextStyle(
    fontFamily: AppTypography.interSemiBold,
    fontSize: 18,
    height: 1.222,
  );

  @override
  final TextStyle button = const TextStyle(
    fontFamily: AppTypography.interMedium,
    fontSize: 18,
    height: 1.222,
  );
  @override
  final TextStyle button2 = const TextStyle(
    fontFamily: AppTypography.interMedium,
    fontSize: 14,
    height: 1.1428,
  );

  @override
  final TextStyle headline = const TextStyle(
    fontFamily: AppTypography.interSemiBold,
    fontSize: 16,
    height: 1.25,
  );
  @override
  final TextStyle subhead = const TextStyle(
    fontFamily: AppTypography.interSemiBold,
    fontSize: 14,
    height: 1.1428,
  );

  @override
  final TextStyle body1 = const TextStyle(
    fontFamily: AppTypography.interRegular,
    fontSize: 16,
    height: 1.25,
  );
  @override
  final TextStyle body2 = const TextStyle(
    fontFamily: AppTypography.interRegular,
    fontSize: 14,
    height: 1.1428,
  );

  @override
  TextStyle get caption => const TextStyle(
        fontFamily: AppTypography.interRegular,
        fontSize: 12,
        height: 1.3333,
      );
}

typedef ATT = AppTypographyTablet;

class AppTypographyTablet extends AppTypography {

  static final AppTypographyTablet _tablet = AppTypographyTablet._internal();

  factory AppTypographyTablet(){
    return _tablet;
  }

  AppTypographyTablet._internal();

  @override
  TextStyle title1 = const TextStyle(
    fontFamily: AppTypography.interBold,
    fontSize: 28,
    height: 1.1428,
  );
  @override
  TextStyle title2 = const TextStyle(
    fontFamily: AppTypography.interBold,
    fontSize: 22,
    height: 1.1818,
  );
  @override
  TextStyle title3 = const TextStyle(
    fontFamily: AppTypography.interBold,
    fontSize: 22,
    height: 1.1818,
  );
  @override
  TextStyle title4 = const TextStyle(
    fontFamily: AppTypography.interSemiBold,
    fontSize: 20,
    height: 1.2,
  );

  @override
  TextStyle button = const TextStyle(
    fontFamily: AppTypography.interMedium,
    fontSize: 18,
    height: 1.222,
  );
  @override
  TextStyle button2 = const TextStyle(
    fontFamily: AppTypography.interMedium,
    fontSize: 14,
    height: 1.1428,
  );

  @override
  TextStyle headline = const TextStyle(
    fontFamily: AppTypography.interSemiBold,
    fontSize: 18,
    height: 1.2222,
  );
  @override
  TextStyle subhead = const TextStyle(
    fontFamily: AppTypography.interSemiBold,
    fontSize: 16,
    height: 1.25,
  );

  @override
  TextStyle body1 = const TextStyle(
    fontFamily: AppTypography.interRegular,
    fontSize: 18,
    height: 1.2222,
  );
  @override
  TextStyle body2 = const TextStyle(
    fontFamily: AppTypography.interRegular,
    fontSize: 16,
    height: 1.25,
  );

  @override
  TextStyle caption = const TextStyle(
    fontFamily: AppTypography.interRegular,
    fontSize: 13,
    height: 1.2307,
  );
}
