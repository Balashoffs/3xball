part of 'match_cubit.dart';

class MatchState extends Equatable {
  final List<PlayerDM> matchPlayers;
  final int matchItem;
  final MatchStatus status;
  final List<int> matchScore;
  final int playerPos;

  @override
  List<Object> get props => [matchPlayers, matchItem, status, matchScore, playerPos];

  const MatchState({
    this.matchPlayers = const [],
    this.matchItem = -1,
    this.status = MatchStatus.idle,
    this.matchScore = const <int>[0,0],
    this.playerPos = -1,
  });

  MatchState copyWith({
    List<PlayerDM>? matchPlayers,
    int? matchItem,
    required MatchStatus status,
    List<int>? matchScore,
    int? playerPos,
  }) {
    return MatchState(
      matchPlayers: matchPlayers ?? this.matchPlayers,
      matchItem: matchItem ?? this.matchItem,
      status: status,
      matchScore: matchScore ?? this.matchScore,
      playerPos: playerPos ?? this.playerPos,
    );
  }
}

enum MatchStatus { idle, ready, selecting, selected, goal, cancel, end}
