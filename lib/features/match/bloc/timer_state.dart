part of 'timer_cubit.dart';

class TimerState extends Equatable {
  final int duration;
  final TimerStatus status;
  final bool isPause;
  @override
  List<Object> get props => [duration, status];

  const TimerState({
    required this.duration ,
    this.status = TimerStatus.idle,
    this.isPause = false,
  });

  TimerState copyWith({
    int? duration,
    TimerStatus? status,
    bool? isPause,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
      isPause: isPause ?? this.isPause,
    );
  }
}


enum TimerStatus{idle, inProgress, pause, complete}