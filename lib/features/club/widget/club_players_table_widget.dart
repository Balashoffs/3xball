
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/extensions/text_style_extension.dart';
import 'package:three_x_ball/core/theme/app_typography.dart';
import 'package:three_x_ball/features/club/bloc/bloc.dart';
import 'package:three_x_ball/features/edit_player/bloc/edit_player_cubit.dart';
import 'package:three_x_ball/features/edit_player/edit_player_bottom_sheet.dart';
import 'package:three_x_ball/model/domain/user_domain.dart';
import 'package:three_x_ball/core/utils/utils.dart';

typedef OnAddPlayer = Function(UserDM player);

class PlayersAtClubWidget extends StatelessWidget {
  const PlayersAtClubWidget({
    Key? key,
    required this.onSetupTourney,
  }) : super(key: key);
  final VoidCallback onSetupTourney;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlayersCubit>();
    return BlocListener<PlayersCubit, PlayersState>(
      listener: (context, state) {
        if (state.lobbyState == PlayersLobbyState.tourney) {
          context.read<PlayersCubit>().init().then((value) => onSetupTourney());
        }
      },
      child: StreamBuilder<List<UserDM>>(
        initialData: const <UserDM>[],
        stream: cubit.getTotalPlayers(),
        builder: (context, snapshot) {
          final players = snapshot.data ?? [];
          if (players.isEmpty) {
            return const SizedBox();
          }
          return PlayersTableWidget(
            players: players,
            onUpdate: (value) {
              context.read<PlayersCubit>().updatePlayer(value);
            },
          );
        },
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
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final player = players[index];
        return GestureDetector(
          onDoubleTap: () async {
            UserDM? updatedPlayer = await showModalBottomSheet(
              constraints: BoxConstraints.tight(Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height * 0.8)),
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              backgroundColor: managerHeadColor,
              builder: (context) {
                return BlocProvider<EditPlayerCubit>(
                  create: (context) => EditPlayerCubit(),
                  child: EditPlayerWidget(playerForEditing: player),
                );
              },
            );
            if (updatedPlayer != null) {
              onUpdate(updatedPlayer);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 14,
                  child: player.selectAvatar(),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player.userLastName,
                        maxLines: 2,
                        style: AT.t.title4.theme,
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
                  fit: FlexFit.tight,
                  flex: 18,
                  child: CellWithBoard(
                    value: ' ${player.age}',
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 18,
                  child: BoldCellWithBoard(value: '${player.rate}'),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 18,
                  child: BoldCellWithBoard(value: '${player.totalGames}'),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: brandColor2BaseBackground,
          endIndent: width * 0.01,
          indent: width * 0.01,
        );
      },
      itemCount: players.length,
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
