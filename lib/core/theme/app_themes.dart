import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';

import 'app_colors.dart';
import 'app_typography.dart';

@immutable
class GradientExtension extends ThemeExtension<GradientExtension> {
  const GradientExtension({
    this.primaryGradient = AppColorsLight.primaryGradient,
    this.primaryLightGradient = AppColorsLight.primaryGradientLight,
    this.primaryDarkGradient = AppColorsLight.primaryGradientDark,
    this.secondaryGradient,
    this.grey100Gradient,
    this.grey30Gradient,
    this.grey10Gradient,
  });

  final LinearGradient? primaryGradient;
  final LinearGradient? primaryLightGradient;
  final LinearGradient? primaryDarkGradient;
  final LinearGradient? secondaryGradient;

  final LinearGradient? grey100Gradient;
  final LinearGradient? grey30Gradient;
  final LinearGradient? grey10Gradient;

  @override
  GradientExtension copyWith({
    LinearGradient? primaryGradient,
    LinearGradient? primaryLightGradient,
    LinearGradient? primaryDarkGradient,
    LinearGradient? secondaryGradient,
    LinearGradient? grey100Gradient,
    LinearGradient? grey30Gradient,
    LinearGradient? grey10Gradient,
  }) {
    return GradientExtension(
      primaryGradient: primaryGradient ?? this.primaryGradient,
      primaryLightGradient: primaryLightGradient ?? this.primaryLightGradient,
      primaryDarkGradient: primaryDarkGradient ?? this.primaryDarkGradient,
      secondaryGradient: secondaryGradient ?? this.secondaryGradient,
      grey100Gradient: grey100Gradient ?? this.grey100Gradient,
      grey30Gradient: grey30Gradient ?? this.grey30Gradient,
      grey10Gradient: grey10Gradient ?? this.grey10Gradient,
    );
  }

  @override
  GradientExtension lerp(GradientExtension? other, double t) {
    if (other is! GradientExtension) {
      return this;
    }
    return GradientExtension(
      primaryGradient:
          LinearGradient.lerp(primaryGradient, other.primaryGradient, t),
      primaryLightGradient: LinearGradient.lerp(
          primaryLightGradient, other.primaryLightGradient, t),
      primaryDarkGradient: LinearGradient.lerp(
          primaryDarkGradient, other.primaryDarkGradient, t),
      secondaryGradient:
          LinearGradient.lerp(secondaryGradient, other.secondaryGradient, t),
      grey100Gradient:
          LinearGradient.lerp(grey100Gradient, other.grey100Gradient, t),
      grey30Gradient:
          LinearGradient.lerp(grey30Gradient, other.grey30Gradient, t),
      grey10Gradient:
          LinearGradient.lerp(grey10Gradient, other.grey10Gradient, t),
    );
  }
}

@immutable
class GreyColorsTheme extends ThemeExtension<GreyColorsTheme> {
  const GreyColorsTheme({
    required this.basic,
    required this.darkLight,
    required this.darkLightTransparent,
    required this.lightDarkTransparent,
    required this.grey,
    required this.grey100,
    required this.grey70,
    required this.grey30,
    required this.grey20,
    required this.grey10,
  });

  final Color basic;
  final Color darkLight;
  final Color darkLightTransparent;
  final Color lightDarkTransparent;
  final Color grey;
  final Color grey100;
  final Color grey70;
  final Color grey30;
  final Color grey20;
  final Color grey10;

  @override
  GreyColorsTheme copyWith({
    Color? basic,
    Color? darkLight,
    Color? darkLightTransparent,
    Color? lightDarkTransparent,
    Color? grey,
    Color? grey100,
    Color? grey70,
    Color? grey30,
    Color? grey20,
    Color? grey10,
  }) {
    return GreyColorsTheme(
      basic: basic ?? this.basic,
      darkLight: darkLight ?? this.darkLight,
      darkLightTransparent: darkLightTransparent ?? this.darkLightTransparent,
      lightDarkTransparent: lightDarkTransparent ?? this.lightDarkTransparent,
      grey: grey ?? this.grey,
      grey100: grey100 ?? this.grey100,
      grey70: grey70 ?? this.grey70,
      grey30: grey30 ?? this.grey30,
      grey20: grey20 ?? this.grey20,
      grey10: grey10 ?? this.grey10,
    );
  }

  @override
  GreyColorsTheme lerp(GreyColorsTheme? other, double t) {
    if (other is! GreyColorsTheme) {
      return this;
    }
    return GreyColorsTheme(
      basic: Color.lerp(basic, other.basic, t)!,
      darkLight: Color.lerp(darkLight, other.darkLight, t)!,
      darkLightTransparent:
          Color.lerp(darkLightTransparent, other.darkLightTransparent, t)!,
      lightDarkTransparent:
          Color.lerp(lightDarkTransparent, other.lightDarkTransparent, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      grey100: Color.lerp(grey100, other.grey100, t)!,
      grey70: Color.lerp(grey70, other.grey70, t)!,
      grey30: Color.lerp(grey30, other.grey30, t)!,
      grey20: Color.lerp(grey20, other.grey20, t)!,
      grey10: Color.lerp(grey10, other.grey10, t)!,
    );
  }
}

@immutable
class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  const AppColorsTheme({
    required this.secondary,
    required this.secondaryLight,
    required this.secondaryDark,
    required this.success,
    required this.warning,
    required this.danger,
  });

  final Color secondary;
  final Color secondaryLight;
  final Color secondaryDark;
  final Color success;
  final Color warning;
  final Color danger;

  @override
  AppColorsTheme copyWith({
    Color? secondary,
    Color? secondaryLight,
    Color? secondaryDark,
    Color? success,
    Color? warning,
    Color? danger,
  }) {
    return AppColorsTheme(
      secondary: secondary ?? this.secondary,
      secondaryLight: secondaryLight ?? this.secondaryLight,
      secondaryDark: secondaryDark ?? this.secondaryDark,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
    );
  }

  @override
  AppColorsTheme lerp(AppColorsTheme? other, double t) {
    if (other is! AppColorsTheme) {
      return this;
    }
    return AppColorsTheme(
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryLight: Color.lerp(secondaryLight, other.secondaryLight, t)!,
      secondaryDark: Color.lerp(secondaryDark, other.secondaryDark, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}

@immutable
class AppIconsTheme extends ThemeExtension<AppIconsTheme> {
  const AppIconsTheme({
    required this.arrowDownSmall,
    required this.bin,
    required this.camera,
    required this.check,
    required this.checkboxMarked,
    required this.chevronDown,
    required this.chevronLeft,
    required this.chevronLeftBig,
    required this.chevronRight,
    required this.chevronUp,
    required this.circleSolid,
    required this.close,
    required this.download,
    required this.eyeClosed,
    required this.eyeOpen,
    required this.filter,
    required this.logout,
    required this.maximize,
    required this.minimize,
    required this.moon,
    required this.moreVertical,
    required this.notification,
    required this.pause,
    required this.pencil,
    required this.play,
    required this.playCircle,
    required this.plus,
    required this.radiobutton,
    required this.radiobuttonMarked,
    required this.refresh,
    required this.search,
    required this.share,
    required this.sortAZ,
    required this.sortZA,
    required this.sun,
    required this.tile,
    required this.tileHorizontal,
    required this.checkBox,
    required this.pin,
    required this.pinSolid,
    required this.star,
    required this.arrowUp,
  });

  final IconData arrowDownSmall;
  final IconData bin;
  final IconData camera;
  final IconData check;
  final IconData checkboxMarked;
  final IconData chevronDown;
  final IconData chevronLeft;
  final IconData chevronLeftBig;
  final IconData chevronRight;
  final IconData chevronUp;
  final IconData circleSolid;
  final IconData close;
  final IconData download;
  final IconData eyeClosed;
  final IconData eyeOpen;
  final IconData filter;
  final IconData logout;
  final IconData maximize;
  final IconData minimize;
  final IconData moon;
  final IconData moreVertical;
  final IconData notification;
  final IconData pause;
  final IconData pencil;
  final IconData play;
  final IconData playCircle;
  final IconData plus;
  final IconData radiobutton;
  final IconData radiobuttonMarked;
  final IconData refresh;
  final IconData search;
  final IconData share;
  final IconData sortAZ;
  final IconData sortZA;
  final IconData sun;
  final IconData tile;
  final IconData tileHorizontal;
  final IconData checkBox;
  final IconData pin;
  final IconData pinSolid;
  final IconData star;
  final IconData arrowUp;

  @override
  AppIconsTheme copyWith({
    IconData? arrowDownSmall,
    IconData? bin,
    IconData? camera,
    IconData? check,
    IconData? checkboxMarked,
    IconData? chevronDown,
    IconData? chevronLeft,
    IconData? chevronLeftBig,
    IconData? chevronRight,
    IconData? chevronUp,
    IconData? circleSolid,
    IconData? close,
    IconData? download,
    IconData? eyeClosed,
    IconData? eyeOpen,
    IconData? filter,
    IconData? logout,
    IconData? maximize,
    IconData? minimize,
    IconData? moon,
    IconData? moreVertical,
    IconData? notification,
    IconData? pause,
    IconData? pencil,
    IconData? play,
    IconData? playCircle,
    IconData? plus,
    IconData? radiobutton,
    IconData? radiobuttonMarked,
    IconData? refresh,
    IconData? search,
    IconData? share,
    IconData? sortAZ,
    IconData? sortZA,
    IconData? sun,
    IconData? tile,
    IconData? tileHorizontal,
    IconData? checkBox,
    IconData? pin,
    IconData? pinSolid,
    IconData? star,
    IconData? arrowUp,
  }) {
    return AppIconsTheme(
      arrowDownSmall: arrowDownSmall ?? this.arrowDownSmall,
      bin: bin ?? this.bin,
      camera: camera ?? this.camera,
      check: check ?? this.check,
      checkboxMarked: checkboxMarked ?? this.checkboxMarked,
      chevronDown: chevronDown ?? this.chevronDown,
      chevronLeft: chevronLeft ?? this.chevronLeft,
      chevronLeftBig: chevronLeftBig ?? this.chevronLeftBig,
      chevronRight: chevronRight ?? this.chevronRight,
      chevronUp: chevronUp ?? this.chevronUp,
      circleSolid: circleSolid ?? this.circleSolid,
      close: close ?? this.close,
      download: download ?? this.download,
      eyeClosed: eyeClosed ?? this.eyeClosed,
      eyeOpen: eyeOpen ?? this.eyeOpen,
      filter: filter ?? this.filter,
      logout: logout ?? this.logout,
      maximize: maximize ?? this.maximize,
      minimize: minimize ?? this.minimize,
      moon: moon ?? this.moon,
      moreVertical: moreVertical ?? this.moreVertical,
      notification: notification ?? this.notification,
      pause: pause ?? this.pause,
      pencil: pencil ?? this.pencil,
      play: play ?? this.play,
      playCircle: playCircle ?? this.playCircle,
      plus: plus ?? this.plus,
      radiobutton: radiobutton ?? this.radiobutton,
      radiobuttonMarked: radiobuttonMarked ?? this.radiobuttonMarked,
      refresh: refresh ?? this.refresh,
      search: search ?? this.search,
      share: share ?? this.share,
      sortAZ: sortAZ ?? this.sortAZ,
      sortZA: sortZA ?? this.sortZA,
      sun: sun ?? this.sun,
      tile: tile ?? this.tile,
      tileHorizontal: tileHorizontal ?? this.tileHorizontal,
      checkBox: checkBox ?? this.checkBox,
      pin: pin ?? this.pin,
      pinSolid: pinSolid ?? this.pinSolid,
      star: star ?? this.star,
      arrowUp: arrowUp ?? this.arrowUp,
    );
  }

  @override
  AppIconsTheme lerp(AppIconsTheme? other, double t) {
    if (other is! AppIconsTheme) {
      return this;
    }
    return AppIconsTheme(
      arrowDownSmall: other.arrowDownSmall,
      bin: other.bin,
      camera: other.camera,
      check: other.check,
      checkboxMarked: other.checkboxMarked,
      chevronDown: other.chevronDown,
      chevronLeft: other.chevronLeft,
      chevronLeftBig: other.chevronLeftBig,
      chevronRight: other.chevronRight,
      chevronUp: other.chevronUp,
      circleSolid: other.circleSolid,
      close: other.close,
      download: other.download,
      eyeClosed: other.eyeClosed,
      eyeOpen: other.eyeOpen,
      filter: other.filter,
      logout: other.logout,
      maximize: other.maximize,
      minimize: other.minimize,
      moon: other.moon,
      moreVertical: other.moreVertical,
      notification: other.notification,
      pause: other.pause,
      pencil: other.pencil,
      play: other.play,
      playCircle: other.playCircle,
      plus: other.plus,
      radiobutton: other.radiobutton,
      radiobuttonMarked: other.radiobuttonMarked,
      refresh: other.refresh,
      search: other.search,
      share: other.share,
      sortAZ: other.sortAZ,
      sortZA: other.sortZA,
      sun: other.sun,
      tile: other.tile,
      tileHorizontal: other.tileHorizontal,
      checkBox: other.checkBox,
      pin: other.pin,
      pinSolid: other.pinSolid,
      star: other.star,
      arrowUp: other.arrowUp,
    );
  }
}

class AppThemes {
  static ThemeData lightThemeMobile() {
    return ThemeData(
      useMaterial3: true,
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: AppColorsLight.primary,
      ),
      extensions: const [
        GreyColorsTheme(
          basic: AppColorsLight.basic,
          darkLight: AppColorsLight.dark,
          darkLightTransparent: AppColorsLight.darkTransparent,
          lightDarkTransparent: AppColorsLight.lightTransparent,
          grey: AppColorsLight.grey,
          grey100: AppColorsLight.grey100,
          grey70: AppColorsLight.grey70,
          grey30: AppColorsLight.grey30,
          grey20: AppColorsLight.grey20,
          grey10: AppColorsLight.grey10,
        ),
        AppColorsTheme(
          secondary: AppColorsLight.secondary,
          secondaryLight: AppColorsLight.secondaryLight,
          secondaryDark: AppColorsLight.secondaryDark,
          success: AppColorsLight.success,
          warning: AppColorsLight.warning,
          danger: AppColorsLight.danger,
        ),
      ],
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light().copyWith(
        error: AppColorsLight.danger,
        secondary: AppColorsLight.secondary,
        tertiary: AppColorsLight.success,
      ),
      disabledColor: AppColorsLight.grey70,
      primaryColor: AppColorsLight.primary,
      primaryColorLight: AppColorsLight.primaryLight,
      primaryColorDark: AppColorsLight.primaryDark,
      focusColor: AppColorsLight.primary,
      scaffoldBackgroundColor: AppColorsLight.basic,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColorsLight.primary,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thickness: MaterialStateProperty.all(4),
        radius: const Radius.circular(2),
        thumbColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.pressed) ||
              states.contains(MaterialState.dragged)) {
            return AppColorsLight.grey70;
          }
          return AppColorsLight.grey30;
        }),
      ),
      appBarTheme: AppBarTheme(
        surfaceTintColor: AppColorsLight.basic,
        backgroundColor: AppColorsLight.basic,
        titleTextStyle: AppTypographyMobile().title3.theme,
        iconTheme: const IconThemeData(
          color: AppColorsLight.dark,
          size: 24,
        ),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColorsLight.dark,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.zero,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorsLight.grey70;
            } else if (states.contains(MaterialState.pressed)) {
              return AppColorsLight.dark;
            }
            return AppColorsLight.grey;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
          // padding: MaterialStateProperty.all(
          //     const EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
          textStyle: MaterialStateProperty.all(
            ATM().button2,
          ),
          backgroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColorsLight.secondary;
            }
            return Colors.transparent;
          }),
          overlayColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColorsLight.secondary;
            }
            return Colors.transparent;
          }),
          minimumSize: MaterialStateProperty.all(
            const Size(0, 40),
          ),
          maximumSize: MaterialStateProperty.all(
            const Size(double.infinity, 40),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorsLight.grey70;
            }
            return AppColorsLight.basic;
          }),
          backgroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorsLight.grey30;
            } else if (states.contains(MaterialState.pressed)) {
              return AppColorsLight.grey;
            }
            return AppColorsLight.grey100;
          }),
          overlayColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorsLight.grey30;
            } else if (states.contains(MaterialState.pressed)) {
              return AppColorsLight.grey;
            }
            return AppColorsLight.grey100;
          }),
          textStyle: MaterialStateProperty.all(
            ATM().button,
          ),
          iconColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorsLight.grey70;
            }
            return AppColorsLight.basic;
          }),
          iconSize: MaterialStateProperty.all(
            24,
          ),
          padding: MaterialStateProperty.all(
            EdgeInsets.zero,
          ),
          elevation: MaterialStateProperty.all(
            0,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            const Size(0, 48),
          ),
          maximumSize: MaterialStateProperty.all(
            const Size(double.infinity, 48),
          ),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColorsLight.primary,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        iconColor: AppColorsLight.dark,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColorsLight.grey30,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColorsLight.grey30,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: AppColorsLight.primary,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: AppColorsLight.danger,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColorsLight.grey30,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIconColor: AppColorsLight.dark,
      ),
      radioTheme: const RadioThemeData(
          splashRadius: 12,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact),
      dividerTheme: const DividerThemeData(
        color: AppColorsLight.grey30,
        thickness: 0.5,
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
 }

extension ThemeDatax on ThemeData {
  bool get isLight => brightness == Brightness.light;

  bool get isDark => brightness == Brightness.light;
}
