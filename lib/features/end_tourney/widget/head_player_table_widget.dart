import 'package:flutter/material.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/core/widget/widget.dart';


class PlayersTableHeadWidget extends StatelessWidget {
  const PlayersTableHeadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text(
              'Итоги турнира',
              style: AT.t.title2.theme,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(color: brandColor2BaseBackground),
          child: const SizedBox(
            height: 35,
            child: Row(
              children: [
                FlexibleTextWidget(text: 'Фамилия Имя',flex:43),
                FlexibleTextWidget(text: 'До',flex:18),
                FlexibleTextWidget(text: 'Разница',flex:18),
                FlexibleTextWidget(text: 'После',flex:18),
              ],
            ),
          ),
        ),
        Divider(
          color: brandColor2BaseBackground,
          endIndent: size.width * 0.01,
          indent: size.width * 0.01,
        ),
      ],
    );
  }
}
