import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/model/domain/domain.dart';

class PlayersTableWidget extends StatelessWidget {
  const PlayersTableWidget({
    Key? key,
    required this.players,
  }) : super(key: key);
  final List<EndPlayerDM> players;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      primary: false,
      child: Column(
        children: generate(players, width),
      ),
    );
  }

  List<Widget> generate(List<EndPlayerDM> players, double width) {
    List<Widget> widgets = [];
    for (int i = 0; i < players.length; i++) {
      widgets.add(UserForSelecting(player: players[i]));
      if (i + 1 < players.length || i != 0) {
        widgets.add(Divider(
          color: brandColor2BaseBackground,
          endIndent: width * 0.01,
          indent: width * 0.01,
        ));
      }
    }
    return widgets;
  }
}

class UserForSelecting extends StatelessWidget {
  const UserForSelecting({
    Key? key,
    required this.player,
  }) : super(key: key);
  final EndPlayerDM player;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Flexible(
            flex: 14,
            fit: FlexFit.tight,
            child: player.selectAvatar(),
          ),
          Flexible(
            flex: 30,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.userLastName,
                  maxLines: 2,
                  style: AT.t.body1.theme,
                ),
                Text(
                  player.userFirstName,
                  maxLines: 2,
                  style: AT.t.body2.theme,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 16,
            fit: FlexFit.tight,
            child: CellWithBoard(value: '${player.rate}'),
          ),
          player.delta == 0
              ? const Flexible(
                  flex: 18,
                  fit: FlexFit.tight,
                  child: CellWithBoard(value: '0'),
                )
              : Flexible(
                  flex: 18,
                  fit: FlexFit.tight,
                  child: CellRowWithBoard(value: player.delta),
                ),
          Flexible(
            flex: 18,
            child: CellWithBoard(value: '${player.rate + player.delta}'),
          ),
        ],
      ),
    );
  }
}

class CellBoardContainer extends StatelessWidget {
  const CellBoardContainer({
    Key? key,
    this.width,
    required this.child,
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
  const CellWithBoard({Key? key, required this.value}) : super(key: key);
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
          color: managerHeadColor,
        ),
        child: SizedBox(
          width: 64,
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

class CellRowWithBoard extends StatelessWidget {
  const CellRowWithBoard({Key? key, required this.value}) : super(key: key);
  final int value;

  @override
  Widget build(BuildContext context) {
    String arrowPath =
        value < 0 ? 'assets/end_tourney/down.svg' : 'assets/end_tourney/up.svg';
    return Container(
      alignment: Alignment.center,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
          color: managerHeadColor,
        ),
        child: SizedBox(
          width: 64,
          height: 28,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(arrowPath),
                Text(
                  '$value',
                  style: AT.t.body2.theme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
