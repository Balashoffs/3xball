import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/widget/widget.dart';
import 'package:three_x_ball/features/between_match/bloc/between_match_cubit.dart';
import 'package:three_x_ball/features/between_match/widgets/widgets.dart';
import 'package:three_x_ball/repository/match_repository.dart';

import '../features/between_match/widgets/setup_header_widget.dart';

class BetweenMatchScreen extends StatelessWidget {
  const BetweenMatchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ExtendedScaffoldWidget(
      canPop: false,
      child: BlocBetweenMatchWidget(),
    );
  }
}

class BlocBetweenMatchWidget extends StatelessWidget {
  const BlocBetweenMatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MatchRepository matchRepository = context.read<MatchRepository>();
    return BlocProvider<BetweenMatchCubit>(
      create: (_) =>
      BetweenMatchCubit(matchRepository: matchRepository)
        ..init(),
      lazy: false,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
        child: BuilderBetweenMatchWidget(),
      ),
    );
  }
}

class BuilderBetweenMatchWidget extends StatelessWidget {
  const BuilderBetweenMatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BetweenMatchCubit, BetweenMatchState>(
      builder: (context, state) {
        if (state.status == BetweenMatchStatus.idle) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            HeadWidget(state: state),
            ScrollBodyWidget(state: state),
            const NextMatchButton(),
          ],
        );
      },
    );
  }
}

class HeadWidget extends StatelessWidget {
  const HeadWidget({super.key, required this.state});

  final BetweenMatchState state;

  @override
  Widget build(BuildContext context) {
    if (state.status == BetweenMatchStatus.start) {
      return const SizedBox.shrink();
    }
    return SetupHeaderWidget(matchResult: state.matchResult,);
  }
}

class ScrollBodyWidget extends StatelessWidget {
  const ScrollBodyWidget({super.key, required this.state});

  final BetweenMatchState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          MatchResultWidget(state: state,),
          NextTriplesWidgetWidget(state: state),
        ],
      ),
    );
  }
}

class NextTriplesWidgetWidget extends StatelessWidget {
  const NextTriplesWidgetWidget({super.key, required this.state});

  final BetweenMatchState state;

  @override
  Widget build(BuildContext context) {
    if (state.status == BetweenMatchStatus.finish) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        NextSquadTitleWidget(nextMatchIndex: state.matchPos),
        const SizedBox(
          height: 8.0,
        ),
        NextSquadWidget(
            microMatchPlayers: state.matchPlayers),
      ],
    );
  }
}

class MatchResultWidget extends StatelessWidget {
  const MatchResultWidget({super.key, required this.state});

  final BetweenMatchState state;

  @override
  Widget build(BuildContext context) {
    if(state.status == BetweenMatchStatus.start){
      return const SizedBox();
    }
    String text = state.status == BetweenMatchStatus.finish
        ? 'Итоговая таблица турнира'
        : 'Таблица после ${state.matchPos - 1} матча';
    return Expanded(
      child: Column(
        children: [
          TableAfterMatchWidget(text: text),
          const HeadMatchResultTableWidget(),
          Expanded(
            child: SingleChildScrollView(
              primary: false,
              child: MatchResultTableWidget(players: state.tourneyPlayers),),
          ),
        ],
      ),
    );
  }
}

