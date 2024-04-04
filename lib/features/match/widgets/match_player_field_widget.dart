import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/features/match/bloc/bloc.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SvgProvider;

class MatchPlayersFieldWidget extends StatelessWidget {
  const MatchPlayersFieldWidget({super.key});

  /*
  Если выбран режим выбора автора гола,
  то прозрачность заднего фона опускается до 0,2 и
  контейнер с именем и аватаркой игрока меняет цвет фона на белый с прозрачностью  до 0,4,
   а при выборе автора гола - его контейнер меня цвет на brandcolor c с прозрачностью 0,4
   */

  @override
  Widget build(BuildContext context) {
    final state = context.select((MatchCubit value) => value.state);
    final userTriples = state.matchPlayers;
    if (userTriples.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          color: brandColorBaseWithOpacity1,
          backgroundColor: brandColorBaseWithOpacity2,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: SizedBox(
        height: 300,
        child: Builder(builder: (context) {
          final status =
              context.select((MatchCubit cubit) => cubit.state.status);
          double opacity =
              status == MatchStatus.selected || status == MatchStatus.selecting
                  ? 0.2
                  : 1.0;
          return DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: const SvgProvider.Svg('assets/match/players_field.svg'),
                opacity: opacity,
              ),
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Center(child: SvgPicture.asset('assets/match/ball_logo.svg')),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2 -16.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          3,
                          (index) {
                            PlayerDM matchPlayer =
                                state.matchPlayers[index * 2];
                            return MatchPlayerWidget(
                              player: matchPlayer,
                              suiteColor: matchPlayer.tileColor!,
                              pos: 'left',
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2 -16.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          3,
                          (index) {
                            PlayerDM matchPlayer =
                                state.matchPlayers[index * 2 + 1];
                            return MatchPlayerWidget(
                              player: matchPlayer,
                              suiteColor: matchPlayer.tileColor!,
                              pos: 'right',
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class MatchPlayerWidget extends StatefulWidget {
  const MatchPlayerWidget({
    super.key,
    required this.player,
    required this.suiteColor,
    required this.pos,
  });

  final PlayerDM player;
  final Color suiteColor;
  final String pos;

  @override
  State<MatchPlayerWidget> createState() => _MatchPlayerWidgetState();
}

class _MatchPlayerWidgetState extends State<MatchPlayerWidget> {
  bool isNotSelecting = true;

  @override
  Widget build(BuildContext context) {
    final state = context.select((MatchCubit cubit) => cubit.state);
    int pos = state.playerPos;
    double colorOpacity = 0.0;
    double borderOpacity = 0.0;

    if (state.status == MatchStatus.selecting) {
      borderOpacity = 0.2;
    } else if (state.status == MatchStatus.selected) {
      borderOpacity = 0.2;
      colorOpacity = widget.player.pos != pos ? 0.0 : 0.2;
    }
    return SizedBox(
      width: 156,
      height: 53,
      child: GestureDetector(
        onTap: () {
          if (state.status == MatchStatus.selecting ||
              state.status == MatchStatus.selected) {
            context.read<MatchCubit>().onSelected(widget.player);
          }
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: Colors.white.withOpacity(borderOpacity)),
            color: Colors.white.withOpacity(colorOpacity),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: widget.pos == 'left'
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: buildPlayerWidget(widget.pos, widget.suiteColor),
          ),
        ),
      ),
    );
  }

  List<Widget> buildPlayerWidget(String pos, Color color) {
    switch (pos) {
      case 'left':
        return [
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: CircleAvatar(
              backgroundColor: color,
              child: widget.player.userDM.selectAvatar(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.player.userDM.userLastName,
                style: AT.t.title4.theme,
              ),
              Text(
                widget.player.userDM.userFirstName,
                style: AT.t.body1.theme,
              ),

            ],
          ),
        ];
      case 'right':
        return [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.player.userDM.userLastName,
                style: AT.t.title4.theme,
              ),
              Text(
                widget.player.userDM.userFirstName,
                style: AT.t.body1.theme,
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4, left: 4),
            child: CircleAvatar(
              backgroundColor: color,
              child: widget.player.userDM.selectAvatar(),
            ),
          ),
        ];
    }
    return [];
  }
}
