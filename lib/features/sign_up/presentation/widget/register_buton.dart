import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:three_x_ball/core/utils/utils.dart';



class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key, this.onTap}) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 32;
    return Padding(
      padding: const EdgeInsets.only( bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: width,
          height: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              shape: BoxShape.rectangle,
              color: brandColorBase,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Text(
                    'Регистрация',
                    style: TextStyle(
                        fontFamily: 'Gilroy-Bold',
                        fontSize: 16,
                        color: Colors.white),
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
                      Positioned(
                        right: 10,
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
