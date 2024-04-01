
import 'package:flutter/material.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';

class FlexibleTextWidget extends StatelessWidget {
  const FlexibleTextWidget({
    Key? key,
    this.flex,
    required this.text,
  }) : super(key: key);
  final int? flex;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex ?? 18,
      child: Center(
        child: Text(
          text,
          style: AT.t.body2.theme,
          maxLines: 2,
        ),
      ),
    );
  }
}
