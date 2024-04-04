import 'dart:async';
import 'dart:developer' as dev;
import 'dart:ui';

import 'package:app_runner/app_runner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/page/splash_screen.dart';
import 'package:three_x_ball/repository/app_repository.dart';
import 'package:three_x_ball/repository/app_store.dart';
import 'package:three_x_ball/repository/match_repository.dart';

import 'core/utils/utils.dart';
import 'page/app_screen.dart';

void log(
  Object? message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  dev.log(
    message?.toString() ?? '',
    time: time,
    sequenceNumber: sequenceNumber,
    level: level,
    name: name,
    zone: zone,
    error: error,
    stackTrace: stackTrace,
  );
}

Future<void> main() async {
  final WidgetConfiguration widgetConfiguration = WidgetConfiguration(
    child: AppBuilder<void>(
      preInitialize: (WidgetsBinding binding) async {
        log('binding type: ${binding.runtimeType}');
        await Future<void>.delayed(const Duration(milliseconds: 5000));
      },
      builder: (
        BuildContext context,
        AsyncSnapshot<void> snapshot,
        Widget? child,
      ) {
        late final Widget child;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            child = CustomSplashScreen(
              message: DartDefine.version,
            );
            continue display;
          case ConnectionState.done:
            AppStore appStore = AppStore();
            AppRepository appRepository = AppRepository(appStore: appStore);
            MatchRepository matchRepository =
                MatchRepository(appRepository: appRepository);
            child = MultiRepositoryProvider(
              providers: [
                RepositoryProvider<AppRepository>.value(value: appRepository),
                RepositoryProvider<MatchRepository>.value(
                    value: matchRepository),
              ],
              child: const AppScreen(),
            );
            continue display;
          display:
          default:
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: child,
            );
        }
      },
    ),
    onFlutterError: (FlutterErrorDetails errorDetails) {
      log(
        errorDetails.toStringShort(),
        name: 'onFlutterError',
        stackTrace: errorDetails.stack,
        error: errorDetails.exception,
      );
    },
    initializeBinding: () => WidgetsFlutterBinding(),
  );

  appRunner(
    kIsWeb
        ? RunnerConfiguration(
            widgetConfig: widgetConfiguration,
            onPlatformError: (Object exception, StackTrace stackTrace) {
              log(
                exception.runtimeType.toString(),
                name: 'onPlatformError',
                stackTrace: stackTrace,
                error: exception,
              );

              return false;
            },
          )
        : RunnerConfiguration.guarded(
            widgetConfig: widgetConfiguration,
            zoneConfig: ZoneConfiguration(
              onZoneError: (Object error, StackTrace stackTrace) {
                log(
                  error.runtimeType.toString(),
                  name: 'onZoneError',
                  stackTrace: stackTrace,
                  error: error,
                );
              },
            ),
          ),
  );
}
