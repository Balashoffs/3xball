part of 'setup_tourney_cubit.dart';

class SetupTourneyState extends Equatable {
  final TourneySetupState state;

  const SetupTourneyState({
    this.state = TourneySetupState.idle,
  });

  @override
  List<Object> get props => [state];

  SetupTourneyState copyWith({
    TourneySetupState? state,
  }) {
    return SetupTourneyState(
      state: state ?? this.state,
    );
  }
}

enum TourneySetupState {
  idle,
  start,
  players,
  reset,
  many,
}
