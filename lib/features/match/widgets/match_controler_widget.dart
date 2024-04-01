import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:three_x_ball/core/utils/colors.dart';
import 'package:three_x_ball/core/utils/styles.dart';
import 'package:three_x_ball/features/match/bloc/bloc.dart';
import 'package:vibration/vibration.dart';

class MatchControllerWidget extends StatefulWidget {
  const MatchControllerWidget({super.key});

  @override
  State<MatchControllerWidget> createState() => _MatchControllerWidgetState();
}

class _MatchControllerWidgetState extends State<MatchControllerWidget> {
  bool isPause = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MatchCubit>();
    if (cubit.state.status == MatchStatus.selected) {
      return const SizedBox.shrink();
    }
    if (cubit.state.status == MatchStatus.finish) {
      return Center(
        child: Text(
          'Матч окончен',
          style: textStyleHeavy(brandColorBase, 32),
        ),
      );
    }
    return Center(
      child: Stack(alignment: Alignment.center, children: [
        Image.asset('assets/match/back.png'),
        GestureDetector(
          onTap: () {
            final bloc = context.read<TimerCubit>();
            if (bloc.state.status == TimerStatus.idle) {
              player.setAsset('assets/match/timer_beat.wav');
              player.setLoopMode(LoopMode.one);
              player.play();
              bloc.start();
            } else {
              context.read<MatchCubit>().onPaused(isPause);
              isPause ? bloc.paused() : bloc.resumed();
            }
            isPause ? player.pause() : player.play();
            isPause = !isPause;
            setState(() {});
          },
          child: isPause
              ? Image.asset(
                  'assets/match/pause_button.png',
                )
              : Image.asset(
                  'assets/match/play_button.png',
                ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
