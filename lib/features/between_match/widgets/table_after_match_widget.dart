import 'package:flutter/material.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';

class TableAfterMatchWidget extends StatelessWidget {
  const TableAfterMatchWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(
          text,
            style: AT.t.title2.theme,
          maxLines: 2,
        ),
      ),
    );
  }
}