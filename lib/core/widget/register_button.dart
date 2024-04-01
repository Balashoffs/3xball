import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.backgroundColor = const Color.fromRGBO(171, 26, 100, 1),
    this.isUpperCase = true,
  }) : super(key: key);
  final VoidCallback? onTap;
  final String buttonText;
  final Color? backgroundColor;
  final bool isUpperCase;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              shape: BoxShape.rectangle,
              color: backgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text(
                    isUpperCase ? buttonText.toUpperCase() : buttonText,
                    style: AT.t.button.theme,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      SizedBox(
                        width: 66,
                        height: 40,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                            shape: BoxShape.rectangle,
                            color: brandColorBase2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(
                          'assets/welcome/arrow.svg',
                          height: 16,
                          width: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmText extends StatelessWidget {
  const ConfirmText(
      {Key? key,
      required this.buttonText,
      this.backgroundColor = const Color.fromRGBO(171, 26, 100, 1),
      this.isUpperCase = true})
      : super(key: key);
  final String buttonText;
  final Color? backgroundColor;
  final bool isUpperCase;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 32;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,
        height: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            shape: BoxShape.rectangle,
            color: backgroundColor,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                buttonText,
                style: AT.t.title2.theme,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
