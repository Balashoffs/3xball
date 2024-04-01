import 'package:flutter/material.dart';
import 'package:three_x_ball/core/utils/colors.dart';
import 'package:three_x_ball/features/club/widget/setup_header_widget.dart';


class SetupHeaderWidget extends StatelessWidget {
  const SetupHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.1;
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/setup_tourney/head_background.png',
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ClubHead(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu,
                    color: brand2ColorBase,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}