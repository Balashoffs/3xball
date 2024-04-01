import 'package:flutter/material.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';

class SetupHeaderWidget extends StatelessWidget {
  const SetupHeaderWidget({
    Key? key, required this.matchResult,
  }) : super(key: key);

  final String matchResult;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 96,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/end_match/end_match_head_background.png',
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Итог матча!', style: AT.t.title4.theme,),
                SizedBox(height: 8,),
                Text(matchResult, style: AT.t.title1.theme,),

                // const SelectPlayersAgesWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
