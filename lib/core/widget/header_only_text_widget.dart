
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.height,
    this.leftText = '',
    this.centerTopText = '',
    this.centerBottomText = '',
    this.onPressed,
  }) : super(key: key);
  final double height;
  final String leftText;
  final String centerTopText;
  final String centerBottomText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage(
              'assets/end_match/end_match_head_background.png',
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text(
                leftText,
                style: textStyleBold(brand2ColorBase, 20),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  centerTopText,
                  style: textStyleBold(brand2ColorBase, 20),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  centerBottomText,
                  style: textStyle(brand2ColorBase, 20),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close, color: brand2ColorBase, size: 24.0),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
