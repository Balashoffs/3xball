
import 'package:flutter/material.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/model/domain/app_domain.dart';

class RegisteredScreen extends StatelessWidget {
  const RegisteredScreen({Key? key, required this.appDomain}) : super(key: key);
  final AppDomain appDomain;

  @override
  Widget build(BuildContext context) {
    return ExtendedScaffoldWidget(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const RegisteredHeadWidget(),
            const SizedBox(
              height: 8,
            ),
            const RegisteredTextWidget(
              padding: EdgeInsets.all(4),
              text: 'ПОЗДРАВЛЯЕМ!',
              fontSize: 44,
              fontFamily: 'Gilroy-Heavy',
            ),
            const RegisteredTextWidget(
              padding: EdgeInsets.all(4),
              text: 'Вы создали ФК',
            ),
            RegisteredClubInfoWidget(
              clubName: appDomain.club.clubName,
              cityName: appDomain.club.cityName,
              countryName: appDomain.club.countryName,
              userFI: appDomain.manager.fullName,
              userAge: appDomain.manager.age,
              userPhone: appDomain.manager.phoneNumber,
            ),
            const RegisteredBottomPhotoWidget(),
            const SizedBox(
              height: 8,
            ),
            ConfirmButton(
              buttonText: 'Войти в клуб',
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/club',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RegisteredHeadWidget extends StatelessWidget {
  const RegisteredHeadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Center(
        child: Image.asset(
          'assets/registered/head_picture.png',
        ),
      ),
    );
  }
}

class RegisteredTextWidget extends StatelessWidget {
  const RegisteredTextWidget({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontFamily,
    required this.padding,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final String? fontFamily;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: fontSize != null
            ? TextStyle(
                fontFamily: fontFamily, fontSize: fontSize, color: Colors.white)
            : AT.t.body1.theme,
      ),
    );
  }
}

class RegisteredClubInfoWidget extends StatelessWidget {
  const RegisteredClubInfoWidget(
      {Key? key,
      required this.clubName,
      required this.cityName,
      required this.countryName,
      required this.userFI,
      required this.userAge,
      required this.userPhone})
      : super(key: key);
  final String clubName;
  final String cityName;
  final String countryName;
  final String userFI;
  final int userAge;
  final String userPhone;

  @override
  Widget build(BuildContext context) {
    final String ageLabel = getAgeLabel(userAge);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FractionallySizedBox(
        widthFactor: 0.93,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(45, 51, 56, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RegisteredTextWidget(
                        padding: const EdgeInsets.all(4.0),
                        text: 'ФК "$clubName"',
                      ),
                      RegisteredTextWidget(
                        padding: const EdgeInsets.all(4.0),
                        text: '$cityName, $countryName',
                      ),
                      Row(
                        children: [
                          const RegisteredTextWidget(
                            padding: EdgeInsets.only(
                              left: 8.0,
                            ),
                            text: 'Менеджер:',
                          ),
                          RegisteredTextWidget(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 2.0),
                            text: userFI,
                          ),
                          RegisteredTextWidget(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 2.0),
                            text: '($userAge $ageLabel)',
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                right: 8.0,
                                left: 8.0,
                              ),
                              child: Icon(
                                Icons.phone,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            RegisteredTextWidget(
                              padding: const EdgeInsets.all(4.0),
                              text: userPhone,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 10,
                  child: Image.asset('assets/registered/default_club.png',
                      color: brandColorBase),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisteredBottomPhotoWidget extends StatelessWidget {
  const RegisteredBottomPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: FractionallySizedBox(
        widthFactor: 0.93,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Image.asset(
            'assets/registered/bottom_1.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
