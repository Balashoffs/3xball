import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/club/bloc/club/club_cubit.dart';
import 'package:three_x_ball/features/end_tourney/bloc/end_tourney_cubit.dart';
import 'package:three_x_ball/features/end_tourney/widget/widget.dart';
import 'package:three_x_ball/repository/app_repository.dart';


class EndTourneyScreen extends StatelessWidget {
  const EndTourneyScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ExtendedScaffoldWidget(
      canPop: false,
      child: BlocEndTourneyWidget(),
    );
  }
}

class BlocEndTourneyWidget extends StatelessWidget {
  const BlocEndTourneyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRepository appRepository = context.read<AppRepository>();
    return MultiRepositoryProvider(
      providers: [
        BlocProvider<EndTourneyCubit>(
          create: (_) => EndTourneyCubit(appRepository: appRepository)..init(),
          lazy: false,
        ),
        BlocProvider<ClubCubit>(
          lazy: false,
          create: (_) => ClubCubit(repository: appRepository)..init(),
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: BuilderEndTourneyWidget(),
      ),
    );
  }
}

class BuilderEndTourneyWidget extends StatelessWidget {
  const BuilderEndTourneyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EndTourneyCubit, EndTourneyState>(
      builder: (context, state) {
        if (state.status == EndTourneyStatus.show) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SetupHeaderWidget(),
                      const SizedBox(
                        height: 8,
                      ),
                      const PlayersTableHeadWidget(),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(child: PlayersTableWidget(players: state.players)),
                    ],
                  ),
                ),
                const UpdatePlayerRateButton(),
              ],
            ),
          );
        }
        return const SizedBox();
      },
      listener: (context, state) {
        if (state.status == EndTourneyStatus.update) {
          Navigator.pushReplacementNamed(
            context,
            '/',
          );
        }
      },
    );
  }
}
