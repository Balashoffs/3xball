
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/widget/register_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundWidget(),
            const ClubLogoWidget(),
            const FootballerWidget(),
            const BackgroundGradient(),
            Positioned.fill(
              top: MediaQuery.of(context).size.height - 236,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HelloWidget(),
                  const WelcomeWidget(),
                  Center(
                    child: ConfirmButton(
                      buttonText: 'Создай свой ФК',
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/sign_in',
                        );
                      },
                    ),
                  ),
                  const LogoWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClubLogoWidget extends StatelessWidget {
  const ClubLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 324,
      right: 104,
      child: Image.asset('assets/welcome/club_logo.png'),
    );
  }
}

class FootballerWidget extends StatelessWidget {
  const FootballerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      bottom: 64,
      left: 136,
      child: Image.asset('assets/welcome/football_player.png'),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome/background.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.black,
              Colors.black
            ],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            stops: [0, 0, 0.75, 1],
          ),
        ),
      ),
    );
  }
}

class HelloWidget extends StatelessWidget {
  const HelloWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        'ПРИВЕТ !',
          style: AT.t.title1.theme,
      ),
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Text(
        'Добро пожаловать в наш игровой клуб',
        style: AT.t.body1.theme,
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/welcome/welcome_logo.svg',
        width: 84,
        height: 35,
      ),
    );
  }
}
