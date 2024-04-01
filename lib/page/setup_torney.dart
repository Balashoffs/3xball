import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/setup_tourney/bloc/bloc.dart';
import 'package:three_x_ball/features/setup_tourney/widgets/widget.dart';
import 'package:three_x_ball/repository/app_repository.dart';


class SetupTourneyScreen extends StatelessWidget {
  const SetupTourneyScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRepository = context.read<AppRepository>();
    return ExtendedScaffoldWidget(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ClubCubit>(
            lazy: false,
            create: (context) => ClubCubit(repository: appRepository)..init(),
          ),
          BlocProvider<SetupTourneyCubit>(
            lazy: false,
            create: (context) =>
                SetupTourneyCubit(repository: appRepository)..loadPlayers(),
          ),
        ],
        child: SetupTourneyWidget(
          onSetupTourney: () {
            Navigator.pushReplacementNamed(
              context,
              '/between_matches',
            );
          },
        ),
      ),
    );
  }
}

class SetupTourneyWidget extends StatelessWidget {
  const SetupTourneyWidget({
    Key? key,
    required this.onSetupTourney,
  }) : super(key: key);

  final VoidCallback onSetupTourney;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SetupHeaderWidget(),
        const SizedBox(
          height: 8,
        ),
        const HeadPlayersTableWidget(),
        PlayersAtClubWidget(onStartTourney: onSetupTourney),
        const StartTourneyButton(),
      ],
    );
  }
}
