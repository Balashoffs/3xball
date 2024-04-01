import 'package:three_x_ball/mapper/app_mapper.dart';
import 'package:three_x_ball/mapper/player_mapper.dart';
import 'package:three_x_ball/mapper/user_mapper.dart';

import '../model/domain/club_domain.dart';
import '../model/domain/user_domain.dart';
import '../model/local_store/club_sp.dart';
import '../model/local_store/player_sp.dart';
import 'app_store.dart';
import 'i_app_store.dart';

class TourneySetupRepository {
  final IClubStore _clubStore;
  final ISetupTourneyStore _tourneyStore;

  TourneySetupRepository({required AppStore appStore})
      : _clubStore = appStore.clubStore,
        _tourneyStore = appStore.tourneyStore;

  Future<ClubDomain> readClub() async {
    ClubSP clubSP = await _clubStore.read();
    if (clubSP.cityName.isNotEmpty) {
      return clubSP.toClubD();
    }
    return ClubDomain.empty();
  }

  Future<void> addTourneyPlayer(List<UserDM> players) async {
    final playersSP = players.map((e) => e.toPlayerSP()).toList();
    _tourneyStore.add(playersSP);
  }

  Future<void> updateTourneyPlayer(List<UserDM> players) async {
    final playersSP = players.map((e) => e.toPlayerSP()).toList();
    _tourneyStore.update(playersSP);
  }

  Future<void> deleteTourneyPlayer() async {
    _tourneyStore.delete;
  }

  Future<List<UserDM>> readTourneyPlayers() async {
    List<PlayerSP> playersSP = await _tourneyStore.read();
    return playersSP.map((e) => e.toPlayerD()).toList();
  }
}
