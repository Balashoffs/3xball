import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/model/domain/user_domain.dart';
import 'package:three_x_ball/repository/app_repository.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  PlayersCubit({required this.repository}) : super(const PlayersState());
  final BehaviorSubject<int> _addedPlayers = BehaviorSubject();
  final BehaviorSubject<List<UserDM>> _totalPlayers = BehaviorSubject();
  final AppRepository repository;

  List<int>? _ageRange;

  Stream<int> getAddedPlayersQnt() async* {
    if (!_addedPlayers.hasValue) {
      List<UserDM> players = await repository.readLobbyPlayers();

      final total = players.length;
      _addedPlayers.add(total);
    }

    yield* _addedPlayers.stream;
  }

  Stream<List<UserDM>> getTotalPlayers() async* {
    if (!_totalPlayers.hasValue) {
      List<UserDM> players = await repository.readLobbyPlayers();
      if (players.isNotEmpty) {
        players.sort();
      }

      _totalPlayers.add(players);
    }

    yield* _totalPlayers;
  }

  Future<void> init() async {
    List<UserDM> players =  await repository.readLobbyPlayers();

    players.sort();
    PlayersLobbyState lobbyState = calc(players);
    emit(PlayersState(lobbyState: lobbyState));
    _addedPlayers.add(players.length);
    _totalPlayers.add(players);
  }

  Future<void> addPlayer(UserDM player) async {
    await repository.addLobbyPlayers([player]);
    onAgeToggle(range: _ageRange);
  }

  Future<void> updatePlayer(UserDM player) async {
    await repository.updateLobbyPlayers([player]);
    List<UserDM> players = await repository.readLobbyPlayers();
    players.sort();
    _addedPlayers.add(players.length);
    _totalPlayers.add(players);
    onAgeToggle(range: _ageRange);
  }

  Future<void> tryToStartTourney() async {
    final selectedPlayers = _totalPlayers.value;
    repository.addTourneyPlayer(selectedPlayers);
    PlayersLobbyState lobbyState = PlayersLobbyState.tourney;
    emit(PlayersState(lobbyState: lobbyState));
  }

  PlayersLobbyState calc(List<UserDM> players) {
    return players.isEmpty
        ? PlayersLobbyState.empty
        : players.length < 6
            ? PlayersLobbyState.notEnough
            : PlayersLobbyState.enough;
  }

  void onAgeToggle({List<int>? range}) async {
    List<UserDM> players;
    _ageRange = range;
    if (range != null) {
      int start = range[0];
      int end = range[1];
      end = end > 17 ? end - 1 : end;
      players = await repository.readLobbyPlayers().then((value) => value
          .where((element) => element.age >= start && element.age <= end)
          .toList());
      players.sort();
    } else {
      players = await repository.readLobbyPlayers();
    }

    _totalPlayers.add(players);
    _addedPlayers.add(players.length);
  }

  void onReset() async {
    List<UserDM> players = await repository.readLobbyPlayers();

    players.sort();
    _ageRange = null;
    _totalPlayers.add(players);
    _addedPlayers.add(players.length);
  }
}
