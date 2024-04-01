part of 'timer_cubit.dart';

class TimerState extends Equatable {
  final int duration;
  final TimerStatus status;
  @override
  List<Object> get props => [duration, status];

  const TimerState({
    required this.duration ,
    this.status = TimerStatus.idle,
  });

  TimerState copyWith({
    int? duration,
    TimerStatus? status,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      status: status ?? this.status,
    );
  }
}


enum TimerStatus{idle, inProgress, pause, complete}