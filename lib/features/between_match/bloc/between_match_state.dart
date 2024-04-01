part of 'between_match_cubit.dart';

class BetweenMatchState extends Equatable {
  final List<PlayerDM> tourneyPlayers;
  final List<PlayerDM> matchPlayers;
  final BetweenMatchStatus status;
  final int matchPos;
  final String matchResult;

  @override
  List<Object> get props => [tourneyPlayers, status, matchPos, matchResult];

  const BetweenMatchState({
    this.tourneyPlayers = const [],
    this.matchPlayers = const [],
    required this.status,
    this.matchPos = 0,
    this.matchResult = '',
  });

  BetweenMatchState copyWith({
    List<PlayerDM>? tourneyPlayers,
    List<PlayerDM>? matchPlayers,
    BetweenMatchStatus? status,
    int? matchPos,
    String? matchResult
  }) {
    return BetweenMatchState(
      tourneyPlayers: tourneyPlayers ?? this.tourneyPlayers,
      matchPlayers: matchPlayers ?? this.matchPlayers,
      status: status ?? this.status,
      matchPos: matchPos ?? this.matchPos,
      matchResult: matchResult ?? this.matchResult,
    );
  }
}

enum BetweenMatchStatus {
  idle,
  start,
  next,
  finish,
}
