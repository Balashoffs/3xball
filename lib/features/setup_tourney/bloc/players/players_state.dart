part of 'players_cubit.dart';

class PlayersState extends Equatable {
  final PlayersLobbyState lobbyState;
  final List<UserDM> players;

  const PlayersState(
      {this.lobbyState = PlayersLobbyState.init, this.players = const []});

  @override
  List<Object?> get props => [lobbyState, players];
}

enum PlayersLobbyState { init, empty, notEnough, enough, tourney, update }
