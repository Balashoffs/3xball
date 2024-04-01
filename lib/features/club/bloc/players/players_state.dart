part of 'players_cubit.dart';

class PlayersState extends Equatable {
  final PlayersLobbyState lobbyState;

  const PlayersState(
      {this.lobbyState = PlayersLobbyState.init, });

  @override
  List<Object?> get props => [lobbyState, ];
}

enum PlayersLobbyState { init, empty, notEnough, enough, tourney}
