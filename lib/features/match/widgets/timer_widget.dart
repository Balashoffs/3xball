import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/utils/colors.dart';
import 'package:three_x_ball/features/match/bloc/match_cubit.dart';
import 'package:three_x_ball/features/match/bloc/timer_cubit.dart';
import 'package:three_x_ball/core/utils/date_time.dart';
import 'package:three_x_ball/core/utils/styles.dart';
import 'package:vibration/vibration.dart';

class MatchTimerWidget extends StatelessWidget {
  const MatchTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MatchCubit>();
    Color timeColor = cubit.state.status == MatchStatus.ready
        ? brand2ColorBase
        : brandColorBase;
    double fontSize = cubit.state.status == MatchStatus.selecting ? 64 : 96;
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        int duration = state.duration;
        if (duration > TimerCubit.afterEnd) {
          if (duration == TimerCubit.afterEnd + TimerCubit.beforeEnd) {
            Vibration.vibrate(
                duration:
                (TimerCubit.beforeEnd * 1000 + 1000));
          }
          duration = duration - TimerCubit.afterEnd;
        }else{
          if(duration == TimerCubit.afterEnd ){
            context.read<MatchCubit>().onFinish();
          }
          duration = 0;
        }

        String timer = toStringTimer(duration);
        if (state.status == TimerStatus.pause || duration == 0) {
          return BlinkedText(
            timerValue: timer,
          );
        }
        return Text(
          timer,
          style: textStyleHeavy(timeColor, fontSize),
        );
      },
    );
  }
}

class BlinkedText extends StatefulWidget {
  const BlinkedText({
    super.key,
    required this.timerValue,
  });

  final String timerValue;

  @override
  State<BlinkedText> createState() => _BlinkedTextState();
}

class _BlinkedTextState extends State<BlinkedText>
    with SingleTickerProviderStateMixin<BlinkedText> {
  late final AnimationController _animationController;
  Color color = brandColorBase;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) =>
          Opacity(
            opacity: _animationController.value,
            child: Text(
              widget.timerValue,
              style: textStyleHeavy(color, 65),
            ),
          ),
    );
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
        color = brand2ColorBase;
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
        color = brandColorBase;
      }
    });

    _animationController.forward();
  }
}
