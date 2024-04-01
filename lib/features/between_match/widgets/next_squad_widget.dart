import 'package:flutter/material.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/model/domain/domain.dart';


class NextSquadTitleWidget extends StatelessWidget {
  const NextSquadTitleWidget({Key? key, required this.nextMatchIndex})
      : super(key: key);
  final int nextMatchIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(
          'Состав на $nextMatchIndex матч',
            style: AT.t.title2.theme,
        ),
      ),
    );
  }
}

class NextSquadWidget extends StatelessWidget {
  const NextSquadWidget({
    Key? key,
    required this.microMatchPlayers,
  }) : super(key: key);
  final List<PlayerDM> microMatchPlayers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: brand3ColorBase),
          child: SizedBox(
            height: 48,
            child: Row(
              children: [
                PlayerCard(
                  player: microMatchPlayers[0],
                ),
                VerticalDivider(
                  color: managerHeadColor,
                  width: 4,
                  thickness: 2,
                  indent: 10,
                  endIndent:10,
                ),
                PlayerCard(
                  player: microMatchPlayers[1],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0,),
        DecoratedBox(
          decoration: BoxDecoration(color: brand3ColorBase),
          child: SizedBox(
            height: 48,
            child: Row(
              children: [
                PlayerCard(
                  player: microMatchPlayers[2],
                ),
                VerticalDivider(
                  color: managerHeadColor,
                  width: 4,
                  thickness: 2,
                  indent: 10,
                  endIndent:10,
                ),
                PlayerCard(
                  player: microMatchPlayers[3],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0,),
        DecoratedBox(
          decoration: BoxDecoration(color: brand3ColorBase),
          child: SizedBox(
            height: 48,
            child: Row(
              children: [
                PlayerCard(
                  player: microMatchPlayers[4],
                ),
                VerticalDivider(
                  color: managerHeadColor,
                  width: 4,
                  thickness: 2,
                  indent: 10,
                  endIndent:10,
                ),
                PlayerCard(
                  player: microMatchPlayers[5],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PlayerCard extends StatelessWidget {
  const PlayerCard({super.key, required this.player});

  final PlayerDM player;

  @override
  Widget build(BuildContext context) {
    final tileColor = player.tileColor;
    final user = player.userDM;
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Row(
        children: [
          _CellBoardContainer(
            width: width * 0.16,
            child: CircleAvatar(
              radius: (user.selectAvatar().height! + 8.0) / 2,
              backgroundColor: tileColor,
              child: user.selectAvatar(),
            ),
          ),
          _CellBoardContainer(
            width: width * 0.30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.userLastName,
                  maxLines: 2,
                  style: AT.t.body1.theme,
                ),
                Text(
                  user.userFirstName,
                  maxLines: 2,
                  style: AT.t.body2.theme,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CellBoardContainer extends StatelessWidget {
  const _CellBoardContainer({
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
