import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {

  static const int beforeEnd = 5;
  static const int afterEnd = 2;
  // static const int timer = 5 * 60 + afterEnd;
  static const int timer = 1 * 30 + afterEnd;

  TimerCubit()
      : _ticker = const Ticker(),
        super(const TimerState(duration: timer)) {
    emit(
      state.copyWith(status: TimerStatus.idle),
    );
  }

  StreamSubscription<int>? _tickerSubscription;
  final Ticker _ticker;

  void start() {
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(
          ticks: state.duration,
        )
        .listen(_onTick);
    emit(state.copyWith(status: TimerStatus.inProgress));
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

  void end(){
    _onTick(afterEnd);
  }

  void _onTick(int duration) {
    if (duration > 0) {
      emit(state.copyWith(status: TimerStatus.inProgress, duration: duration));
    } else{
      emit(state.copyWith(status: TimerStatus.complete, duration: duration));
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
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
