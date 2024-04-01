import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

typedef PS = PlatformService;

class PlatformService {
  static BuildContext? _context;

  static const tabletPortraitScreenWidth = 768;
  static const tabletLandscapeScreenWidth = 1024;
  static const desktopScreenWidth = 1440;

  static void setContext(BuildContext context) {
    PlatformService._context = context;
  }

  static bool get isMobile => isMobileOf(_context);

  static bool get isTabletPortrait => isTabletPortraitOf(_context);

  static bool get isTabletLandscape => isTabletLandscapeOf(_context);

  static bool get isDesktop => isDesktopOf(_context);

  static bool isMobileOf(BuildContext? context) {
    final trueContext = context ?? _context;
    if (trueContext != null) {
      return MediaQuery.of(trueContext).size.width < tabletPortraitScreenWidth;
    }
    return false;
  }

  static bool isTabletPortraitOf(BuildContext? context) {
    final trueContext = context ?? _context;
    if (trueContext != null) {
      final width = MediaQuery.of(trueContext).size.width;
      return width < tabletLandscapeScreenWidth &&
          width >= tabletPortraitScreenWidth;
    }
    return false;
  }

  static bool isTabletLandscapeOf(BuildContext? context) {
    final trueContext = context ?? _context;
    if (trueContext != null) {
      final width = MediaQuery.of(trueContext).size.width;
      return width < desktopScreenWidth && width >= tabletLandscapeScreenWidth;
    }
    return true;
  }

  static bool isDesktopOf(BuildContext? context) {
    final trueContext = context ?? _context;
    if (trueContext != null) {
      final width = MediaQuery.of(trueContext).size.width;
      return width >= desktopScreenWidth;
    }
    return false;
  }

  static String get platform => Platform.operatingSystem;

  static bool get isWeb {
    return kIsWeb;
  }

  static bool isMobileWeb = false;
  static String renderer = 'canvas';
}
