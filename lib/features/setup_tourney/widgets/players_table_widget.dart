import 'dart:core';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/setup_tourney/bloc/bloc.dart';
import 'package:three_x_ball/model/domain/domain.dart';

class PlayersAtClubWidget extends StatelessWidget {
  const PlayersAtClubWidget({
    Key? key,
    required this.onStartTourney,
  }) : super(key: key);
  final VoidCallback onStartTourney;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SetupTourneyCubit>();
    return Expanded(
      child: BlocListener<SetupTourneyCubit, SetupTourneyState>(
        listener: (context, state) {
          if (state.state == TourneySetupState.start) {
            onStartTourney();
          }
        },
        child: StreamBuilder<List<UserDM>>(
          initialData: const [],
          stream: cubit.loadedPlayers(),
          builder: (context, snapshot) {
            final players = snapshot.data;
            if (players!.isEmpty) {
              return const SizedBox();
            }

            return PlayersTableWidget(
              players: players,
              onUpdate: (value) {
                context.read<SetupTourneyCubit>().tapOn(value);
              },
            );
          },
        ),
      ),
    );
  }
}

class PlayersTableWidget extends StatelessWidget {
  const PlayersTableWidget({
    Key? key,
    required this.players,
    required this.onUpdate,
  }) : super(key: key);
  final List<UserDM> players;
  final ValueChanged<UserDM> onUpdate;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: generate(players, width),
      ),
    );
  }
}

List<Widget> generate(List<UserDM> players, double width) {
  List<Widget> widgets = [];
  for (int i = 0; i < players.length; i++) {
    widgets.add(UserForSelecting(player: players[i]));
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

class UserForSelecting extends StatefulWidget {
  const UserForSelecting({
    Key? key,
    required this.player,
  }) : super(key: key);
  final UserDM player;

  @override
  State<UserForSelecting> createState() => _UserForSelectingState();
}

class _UserForSelectingState extends State<UserForSelecting> {
  Color? tileColor;
  Color cellColor = managerHeadColor;
  late Stream<List<String>> resetStream;

  @override
  void initState() {
    super.initState();
    resetStream = context.read<SetupTourneyCubit>().resetIds();
    String id = widget.player.id;
    resetStream.listen((event) {
      if (event.isNotEmpty) {
        if (event.indexWhere((element) => element == id) > -1) {
          tileColor = null;
          // setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool isTap = context.read<SetupTourneyCubit>().tapOn(widget.player);
        if (isTap) {
          if (tileColor == null) {
            tileColor = brandColor2BaseBackground;
            cellColor = brandColorBaseBackground;
          } else {
            tileColor = null;
            cellColor = managerHeadColor;
          }
          setState(() {});
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(color: tileColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 14,
                fit: FlexFit.tight,
                child: widget.player.selectAvatar(),
              ),
              Flexible(
                flex: 30,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.player.userLastName,
                      maxLines: 2,
                      style: AT.t.title4.theme,
                    ),
                    Text(
                      widget.player.userFirstName,
                      maxLines: 2,
                      style: AT.t.body2.theme,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 18,
                fit: FlexFit.tight,
                child: CellWithBoard(
                  value: '${widget.player.age}',
                  color: cellColor,
                ),
              ),
              Flexible(
                flex: 18,
                fit: FlexFit.tight,
                child: BoldCellWithBoard(
                  value: '${widget.player.rate}',
                ),
              ),
              Flexible(
                flex: 18,
                fit: FlexFit.tight,
                child: CellWithBoard(
                  value: '${widget.player.totalGames}',
                  color: cellColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
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

class BoldCellWithBoard extends StatelessWidget {
  const BoldCellWithBoard({
    Key? key,
    required this.value,
  }) : super(key: key);
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
    );
  }
}
