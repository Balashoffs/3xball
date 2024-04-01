import 'package:flutter/material.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/core/widget/widget.dart';

class HeadPlayersTableWidget extends StatelessWidget {
  const HeadPlayersTableWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: brandColor2BaseBackground),
          child: const SizedBox(
            height: 48.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlexibleTextWidget(text: 'Фамилия Имя', flex: 44,),
                FlexibleTextWidget(text: 'Возраст', flex: 18),
                FlexibleTextWidget(text: 'Рейтинг', flex: 18),
                FlexibleTextWidget(text: 'Турниры', flex: 18),
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
