import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_themes.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/colors.dart';

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      text: message,
      backGroundImagePath: 'assets/splash/background.png',
      splashImagePath: 'assets/splash/logo_at_splash.svg',
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
    required this.text,
    required this.backGroundImagePath,
    required this.splashImagePath,
  });

  final String text;
  final String backGroundImagePath;
  final String splashImagePath;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightThemeMobile(),
      themeMode: ThemeMode.light,
      home: Scaffold(
        body: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(backGroundImagePath), fit: BoxFit.fill),
              ),
              child: Stack(
                children: [
                  Center(
                    child: SvgPicture.asset(splashImagePath),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 164.0),
                          child: LinearProgressIndicator(
                            color: brandColorBase,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Text(
                            text,
                            style: AT.t.title4.theme,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
