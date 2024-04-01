import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:three_x_ball/repository/app_repository.dart';
import 'package:three_x_ball/repository/tourney_repository.dart';

import '../../../../model/domain/user_domain.dart';

part 'setup_tourney_state.dart';

class SetupTourneyCubit extends Cubit<SetupTourneyState> {
  SetupTourneyCubit({required this.repository})
      : super(
          const SetupTourneyState(),
        );

  final AppRepository repository;

  void loadPlayers() async {
    List<UserDM> players = await repository.readTourneyPlayers();
    players.sort();
    emit(const SetupTourneyState(
      state: TourneySetupState.players,
    ));
    _playersQntController.add(6);
    _loadedPlayersController.add(players);
  }

  final BehaviorSubject<int> _selectedPlayersController = BehaviorSubject();
  final BehaviorSubject<List<String>> _resetIds = BehaviorSubject();
  final BehaviorSubject<int> _playersQntController = BehaviorSubject();
  final BehaviorSubject<bool> _allowStartController = BehaviorSubject();
  final BehaviorSubject<List<UserDM>> _loadedPlayersController =
      BehaviorSubject();

  final Map<String, UserDM> _playersForTourney = {};

  int _selectedQnt = 0;

  Stream<List<String>> resetIds() async*{
    yield* _resetIds;
  }

  Stream<bool> needToStart() async* {
    if (!_allowStartController.hasValue) {
      _allowStartController.add(false);
    }

    yield* _allowStartController.stream;
  }

  Stream<List<UserDM>> loadedPlayers() async* {
    yield* _loadedPlayersController.stream;
  }

  Stream<int> selectedPlayers() async* {
    if (!_selectedPlayersController.hasValue) {
      _selectedPlayersController.add(_playersForTourney.length);
    }

    yield* _selectedPlayersController.stream;
  }

  Stream<int> totalPlayers() async* {
    yield* _playersQntController.stream;
  }

  int get total => _playersQntController.value;

  bool tapOn(UserDM player) {
    int playerQnt = _playersQntController.value;
    int selectPlayersQnt = _selectedPlayersController.value;
    if (_playersForTourney.containsKey(player.id)) {
      _playersForTourney.remove(player.id);
      _selectedQnt--;
      _selectedPlayersController.add(_selectedQnt);
      if (playerQnt - selectPlayersQnt == 0) {
        _allowStartController.add(false);
        return true;
      }
    } else {
      if (playerQnt > selectPlayersQnt) {
        _playersForTourney[player.id] = player;
        _selectedQnt++;
        _selectedPlayersController.add(_selectedQnt);
        if (_selectedQnt == playerQnt) {
          emit(state.copyWith(state: TourneySetupState.players));
          _allowStartController.add(true);
        }
      } else {
        emit(state.copyWith(state: TourneySetupState.many));
      }
    }
    return selectPlayersQnt + 1 <= playerQnt;
  }

  void tryToStartTourney() async {
    await repository.deleteTourneyPlayer();
    repository.addTourneyPlayer(_playersForTourney.values.toList());
    emit(state.copyWith(state: TourneySetupState.start));
  }

  void onTotalPlayersToggle(int total) async {
    List<UserDM> players = await repository.readTourneyPlayers();
    players.sort();
    _resetIds.add(_playersForTourney.keys.toList());
    _playersQntController.add(total);
    _allowStartController.add(total == _playersForTourney.length);
    _loadedPlayersController.add(players);
    _playersForTourney.clear();
    _selectedPlayersController.add(0);
    _selectedQnt = 0;
  }
}
