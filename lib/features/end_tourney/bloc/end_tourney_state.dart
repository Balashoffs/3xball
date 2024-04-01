part of 'end_tourney_cubit.dart';

class EndTourneyState extends Equatable {

  final EndTourneyStatus status;
  final List<EndPlayerDM> players;

  const EndTourneyState({
    required this.status,
    this.players = const [],
  });


  @override
  // TODO: implement props
  List<Object?> get props => [status, players];


}

enum EndTourneyStatus {
  idle,
  show,
  update,
}
