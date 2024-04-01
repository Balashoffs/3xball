import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/club/bloc/bloc.dart';
import 'package:three_x_ball/features/club/widget/widget.dart';
import 'package:three_x_ball/repository/app_repository.dart';


class ClubScreen extends StatelessWidget {
  const ClubScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ExtendedScaffoldWidget(
      child: ClubBlocWidget(),
    );
  }
}

class ClubBlocWidget extends StatelessWidget {
  const ClubBlocWidget({Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRepository = context.read<AppRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayersCubit>(
          lazy: false,
          create: (_) => PlayersCubit(repository: appRepository)..init(),
        ),
        BlocProvider<ClubCubit>(
          lazy: false,
          create: (_) => ClubCubit(repository: appRepository)..init(),
        ),
        BlocProvider<SelectAgeCubit>(create: (_) => SelectAgeCubit()),
      ],
      child: ClubLobbyWidget(
        onSetupTourney: () {
          Navigator.pushNamed(
            context,
            '/setup_tourney',
          );
        },
      ),
    );
  }
}

class ClubLobbyWidget extends StatelessWidget {
  const ClubLobbyWidget({
    Key? key,
    required this.onSetupTourney,
  }) : super(key: key);
  final VoidCallback onSetupTourney;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.read<PlayersCubit>();
    return Column(
      children: [
        const SetupHeaderWidget(),
        const SizedBox(
          height: 8,
        ),
        const PlayersTableHeadWidget(),
        Expanded(
          child: PlayersAtClubWidget(onSetupTourney: onSetupTourney),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: size.height * 0.18,
          child: Column(
            children: [
              AddPlayerButton(
                right: size.width * 0.05,
                onAdd: (player) {
                  cubit.addPlayer(player);
                },
              ),
              const ToSetupTourneyWidget(),
            ],
          ),
        )
      ],
    );
  }
}
