import 'package:flutter/material.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/model/domain/domain.dart';

class HeadMatchResultTableWidget extends StatelessWidget {
  const HeadMatchResultTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: brandColor2BaseBackground),
          child: const SizedBox(
            height: 36.0,
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlexibleTextWidget(text: 'Фамилия Имя', flex: 47),
                FlexibleTextWidget(text: 'Матчи', flex: 25),
                FlexibleTextWidget(text: 'Очки', flex: 25),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MatchResultTableWidget extends StatelessWidget {
  const MatchResultTableWidget({super.key, required this.players});

  final List<PlayerDM> players;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: generate(players, width),
    );
  }
}

List<Widget> generate(List<PlayerDM> players, double width) {
  List<Widget> widgets = [];
  for (int i = 0; i < players.length; i++) {
    widgets.add(RowMatchResultWidget(player: players[i]));
    if (i + 1 != players.length) {
      widgets.add(Divider(
        color: brandColor2BaseBackground,
        endIndent: width * 0.01,
        indent: width * 0.01,
      ));
    }
  }
  return widgets;
}

class RowMatchResultWidget extends StatelessWidget {
  const RowMatchResultWidget({super.key, required this.player});
  final PlayerDM player;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 14,
            child: player.userDM.selectAvatar(),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 33,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  player.userDM.userLastName,
                  maxLines: 2,
                  style: AT.t.title4.theme,
                ),
                Text(
                  player.userDM.userFirstName,
                  maxLines: 2,
                  style: AT.t.body1.theme,
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 25,
            child: CellWithBoard(
              value: '${player.matchQnt}',
              color: managerHeadColor,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 25,
            child: CellWithBoard(
              value: '${player.score}',
              color: managerHeadColor,
            ),
          ),
        ],
      ),
    );
  }
}


class CellBoardContainer extends StatelessWidget {
  const CellBoardContainer({
    Key? key,
    required this.child,
    this.width,
  }) : super(key: key);
  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 0.15,
      color: Colors.white.withOpacity(0.0),
      child: child,
    );
  }
}

class CellWithBoard extends StatelessWidget {
  const CellWithBoard({
    Key? key,
    required this.color,
    required this.value,
  }) : super(key: key);
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
          color: color,
        ),
        child: SizedBox(
          width: 45,
          height: 28,
          child: Center(
            child: Text(
              value,
              style: AT.t.body1.theme,
            ),
          ),
        ),
      ),
    );
  }
}
