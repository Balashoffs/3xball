import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/model/domain/user_domain.dart';
import 'package:three_x_ball/repository/app_repository.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  PlayersCubit({required this.repository}) : super(const PlayersState());

  final AppRepository repository;

  Future<void> init() async {
    List<UserDM> players = await repository.readLobbyPlayers();
    players.sort();
    PlayersLobbyState lobbyState = calc(players);
    emit(PlayersState(players: players, lobbyState: lobbyState));
  }

  Future<void> addPlayer(UserDM player) async {
    await repository.addLobbyPlayers([player]);
    List<UserDM> players = await repository.readLobbyPlayers();
    PlayersLobbyState lobbyState = calc(players);
    players.sort();
    emit(PlayersState(players: players, lobbyState: lobbyState));

  }


  Future<void> updatePlayer(UserDM player) async {
    await repository.updateLobbyPlayers([player]);
    PlayersLobbyState lobbyState = PlayersLobbyState.update;
    List<UserDM> players = await repository.readLobbyPlayers();
    players.sort();
    emit(PlayersState(players: players, lobbyState: lobbyState));
  }

  Future<void> tryToStartTourney() async {
    List<UserDM> players = await repository.readLobbyPlayers();
    PlayersLobbyState lobbyState = PlayersLobbyState.tourney;
    emit(PlayersState(players: players, lobbyState: lobbyState));
  }

  PlayersLobbyState calc(List<UserDM> players) {
    return players.isEmpty
        ? PlayersLobbyState.empty
        : players.length < 6
            ? PlayersLobbyState.notEnough
            : PlayersLobbyState.enough;
  }
}
