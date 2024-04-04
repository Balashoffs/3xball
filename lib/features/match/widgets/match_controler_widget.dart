import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:three_x_ball/features/match/bloc/bloc.dart';

class MatchControllerWidget extends StatefulWidget {
  const MatchControllerWidget({super.key});

  @override
  State<MatchControllerWidget> createState() => _MatchControllerWidgetState();
}

class _MatchControllerWidgetState extends State<MatchControllerWidget> {
  bool isPause = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MatchCubit>();
    if (cubit.state.status == MatchStatus.selected) {
      return const SizedBox();
    }
    return Center(
      child: GestureDetector(
        onTap: () {
          final bloc = context.read<TimerCubit>();
          if (bloc.state.status == TimerStatus.idle) {
            bloc.start();
          } else {
            context.read<MatchCubit>().onPaused(isPause);
            isPause ? bloc.paused() : bloc.resumed();
          }
          isPause = !isPause;
          setState(() {});
        },
        child: isPause
            ? SvgPicture.asset(
          'assets/match/pause_button.svg',
        )
            : SvgPicture.asset(
          'assets/match/play_button.svg',
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
