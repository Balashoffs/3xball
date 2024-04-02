import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/core/service/sound_manager.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  static const int secondToEndMatch = 30;
  static const int totalSecondsPerMatch = 1 * 30;

  TimerCubit()
      : _ticker = const Ticker(),
        _tickerPlayer = TickerPlayer(),
        super(const TimerState(duration: totalSecondsPerMatch)) {
    emit(
      state.copyWith(status: TimerStatus.idle),
    );
  }

  StreamSubscription<int>? _tickerSubscription;
  final Ticker _ticker;
  final TickerPlayer _tickerPlayer;

  void start() {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(
          ticks: state.duration,
        )
        .listen(_onTick);
    emit(state.copyWith(status: TimerStatus.inProgress));
    _tickerPlayer.play();
  }

  void paused() {
    if (state.status == TimerStatus.inProgress) {
      _tickerSubscription?.pause();
      emit(state.copyWith(status: TimerStatus.pause));
    }
  }

  void resumed() {
    if (state.status == TimerStatus.pause) {
      _tickerSubscription?.resume();
      emit(
        state.copyWith(status: TimerStatus.inProgress),
      );
    }
  }

  void reset() {
    _tickerSubscription?.cancel();
    emit(
      state.copyWith(status: TimerStatus.complete),
    );
  }

  void _onTick(int duration) {
    if (duration > 0) {
      emit(state.copyWith(status: TimerStatus.inProgress, duration: duration));
    } else {
      emit(state.copyWith(status: TimerStatus.complete, duration: duration));
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    _tickerPlayer.stop();
    return super.close();
  }
}

class Ticker {
  const Ticker();

  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
