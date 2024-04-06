import 'dart:ui';

import 'package:three_x_ball/core/utils/colors.dart';
import 'package:three_x_ball/mapper/app_mapper.dart';
import 'package:three_x_ball/mapper/player_mapper.dart';
import 'package:three_x_ball/mapper/user_mapper.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:three_x_ball/model/domain/user_domain.dart';
import 'package:three_x_ball/model/local_store/club_sp.dart';
import 'package:three_x_ball/model/local_store/end_player_sp.dart';
import 'package:three_x_ball/model/local_store/manager_sp.dart';
import 'package:three_x_ball/model/local_store/player_sp.dart';
import 'package:three_x_ball/repository/i_app_store.dart';

import 'app_store.dart';

class AppRepository {
  final IClubStore _clubStore;
  final IManagerStore _managerStore;
  final IPlayersStore _playersStore;
  final ISetupTourneyStore _tourneyStore;
  final IEndTourneyStore _endTourneyStore;

  AppRepository({required AppStore appStore})
      : _clubStore = appStore.clubStore,
        _tourneyStore = appStore.tourneyStore,
        _managerStore = appStore.managerStore,
        _endTourneyStore = appStore.endTourneyStore,
        _playersStore = appStore.playersStore;

  ///Club store
  Future<void> createClub(ClubSP clubSP) async {
    _clubStore.create(clubSP);
  }

  Future<ClubDomain> readClub() async {
    ClubSP clubSP = await _clubStore.read();
    if (clubSP.cityName.isNotEmpty) {
      return clubSP.toClubD();
    }
    return ClubDomain.empty();
  }

  Future<void> updateClub(ClubSP clubSP) async {
    _clubStore.update(clubSP);
  }


  ///Manager store
  Future<void> createManager(ManagerSP managerSP) async {
    _managerStore.create(managerSP);
  }

  Future<ManagerDomain> readManager() async {
    ManagerSP managerSP = await _managerStore.read();
    if (managerSP.id.isNotEmpty) {
      return managerSP.toManagerD();
    }
    return ManagerDomain.empty();
  }

  Future<void> updateManager(ManagerSP managerSP) async {
    _managerStore.update(managerSP);
  }


  ///Clubs' players store
  Future<void> addLobbyPlayers(List<UserDM> lobbyPlayers) async {
    List<PlayerSP> players = lobbyPlayers.map((e) => e.toPlayerSP()).toList();
    _playersStore.add(players);
  }

  Future<List<UserDM>> readLobbyPlayers() async {
    List<PlayerSP> players = await _playersStore.read();
    return players.map((e) => e.toPlayerD()).toList();
  }

  Future<void> updateLobbyPlayers(List<UserDM> lobbyPlayers) async {
    List<PlayerSP> players = lobbyPlayers.map((e) => e.toPlayerSP()).toList();
    _playersStore.update(players);
  }

  Future<void> deleteLobbyPlayers() async{
    await _playersStore.delete();
  }


  ///Pre tourneys' players store
  Future<void> addTourneyPlayer(List<UserDM> players) async {
    final playersSP = players.map((e) => e.toPlayerSP()).toList();
    _tourneyStore.add(playersSP);
  }

  Future<List<UserDM>> readTourneyPlayers() async {
    List<PlayerSP> playersSP = await _tourneyStore.read();
    return playersSP.map((e) => e.toPlayerD()).toList();
  }

  Future<void> updateTourneyPlayer(List<UserDM> players) async {
    final playersSP = players.map((e) => e.toPlayerSP()).toList();
    _tourneyStore.update(playersSP);
  }

  Future<void> deleteTourneyPlayer() async {
    _tourneyStore.delete;
  }



  ///Match store
  ///Pre tourneys' players store
  Future<List<UserDM>> readMatchPlayers() async {
    List<PlayerSP> playersSP = await _tourneyStore.read();
    return playersSP.map((e) => e.toPlayerD()).toList();
  }

  Future<void> updateMatchPlayer(List<UserDM> players) async {
    final playersSP = players.map((e) => e.toPlayerSP()).toList();
    _tourneyStore.update(playersSP);
  }


  ///Tile Color
  List<Color> readPlayerTileColors() {
    return [brandColorBase, brand2ColorBase];
  }


  ///EndPlayers store
  Future<void> addEndTourneyPlayers(List<EndPlayerDM> players) async{
    final playersSP = players.map((e) => e.toEndPlayerSP()).toList();
    _endTourneyStore.add(playersSP);
  }

  Future<List<EndPlayerDM>> readEndTourneyPlayers() async {
    List<EndPlayerSP> playersSP = await _endTourneyStore.read();
    return playersSP.map((e) => e.toEndPlayerDM()).toList();
  }

  Future<void> updateEndTourneyPlayer(List<EndPlayerDM> players) async {
    final playersSP = players.map((e) => e.toEndPlayerSP()).toList();
    _endTourneyStore.update(playersSP);
  }

  Future<void> deleteEndTourneyPlayer() async {
    _endTourneyStore.delete();
  }

}
