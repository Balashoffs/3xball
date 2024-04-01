
import 'package:flutter/material.dart';
import 'package:three_x_ball/page/club_screen.dart';
import 'package:three_x_ball/page/check_screen.dart';
import 'package:three_x_ball/features/sign_up/presentation/sign_up_screen.dart';
import 'package:three_x_ball/model/domain/app_domain.dart';
import 'package:three_x_ball/page/between_match_screen.dart';
import 'package:three_x_ball/page/end_tourney_screen.dart';
import 'package:three_x_ball/page/match_screen.dart';
import 'package:three_x_ball/page/registered_screen.dart';
import 'package:three_x_ball/page/welcome_screen.dart';

import 'page/setup_torney.dart';

class RouteGenerator {
  static Route<dynamic> generatorRoute(RouteSettings settings) {

    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const CheckScreen(),
        );
      case '/club':
        return MaterialPageRoute(
          builder: (_) => const ClubScreen(),
        );
      case '/welcome':
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
      case '/sign_in':
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );
      case '/registered':
        if (args is AppDomain) {
          return MaterialPageRoute(
            builder: (_) => RegisteredScreen(appDomain: args),
          );
        }
      case '/setup_tourney':
        return MaterialPageRoute(
          builder: (_) => const SetupTourneyScreen(),
        );
      case '/between_matches':
        return MaterialPageRoute(
          builder: (_) => const BetweenMatchScreen(),
        );
      case '/match':
        return MaterialPageRoute(
          builder: (_) => const MatchScreen(),
        );
      case '/end_tourney':
        return MaterialPageRoute(
          builder: (_) => const EndTourneyScreen(),
        );
    }
    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
