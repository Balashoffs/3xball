import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/match/bloc/bloc.dart';
import 'package:three_x_ball/features/match/widgets/widgets.dart';
import 'package:three_x_ball/repository/match_repository.dart';
import 'package:vibration/vibration.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExtendedScaffoldWidget(
      canPop: false,
      child: MatchBlocWidget(),
    );
  }
}

class MatchBlocWidget extends StatelessWidget {
  const MatchBlocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MatchRepository matchRepository = context.read<MatchRepository>();
    return MultiBlocProvider(providers: [
      BlocProvider<TimerCubit>(create: (_) => TimerCubit(), lazy: false),
      BlocProvider<MatchCubit>(
          create: (_) => MatchCubit(matchRepository: matchRepository)..init(),
          lazy: false),
    ], child: const MatchBuilderWidget());
  }
}

class MatchBuilderWidget extends StatelessWidget {
  const MatchBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MatchCubit, MatchState>(
      listener: (context, state) {
        if (state.status == MatchStatus.end) {
          context.read<MatchCubit>().saveMatchResult();
          context
              .read<MatchCubit>()
              .close()
              .then((value) => context.read<TimerCubit>().close())
              .then((value) => Navigator.of(context).pop());
        }
        if (state.status == MatchStatus.finish) {
          context.read<MatchCubit>().onClosed();
        }
      },
      child: BlocListener<TimerCubit, TimerState>(
        listener: (context, state) {
          if (state.status == TimerStatus.complete) {
            context.read<MatchCubit>().onClosed();
          }

        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MatchHeaderWidget(),
                MatchPlayersFieldWidget(),
                SelectGoalAuthorWidget(),
              ],
            ),
            Flexible(child: MatchControllerWidget()),
            Flexible(child: MatchTimerWidget()),
            ContinueMatchButton(),
          ],
        ),
      ),
    );
  }
}
