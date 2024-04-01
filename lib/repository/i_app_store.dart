import '../model/local_store/end_player_sp.dart';
import '../model/local_store/club_sp.dart';
import '../model/local_store/manager_sp.dart';
import '../model/local_store/player_sp.dart';

abstract class IClubStore {


  Future<ClubSP> read() async {
    return ClubSP.empty();
  }

  Future<void> create(ClubSP clubSP) async {}

  Future<void> update(ClubSP clubSP) async {}
}

abstract class IManagerStore {


  Future<ManagerSP> read() async {
    return ManagerSP.empty();
  }

  Future<void> create(ManagerSP managerSP) async {}

  Future<void> update(ManagerSP managerSP) async {}
}

abstract class IPlayersStore {
  Future<List<PlayerSP>> read() async {
    return [];
  }
  Future<void> update(List<PlayerSP> players) async {}
  Future<void> add(List<PlayerSP> players) async {}
  Future<void> delete() async {}
}

abstract class ISetupTourneyStore{
  Future<void> add(List<PlayerSP> players) async {}
  Future<void> update(List<PlayerSP> players) async {}
  Future<List<PlayerSP>> read() async {
    return [];
  }
  Future<void> delete() async {}
}

abstract class IEndTourneyStore{
  Future<void> add(List<EndPlayerSP> players) async {}
  Future<void> update(List<EndPlayerSP> players) async {}
  Future<List<EndPlayerSP>> read() async {
    return [];
  }
  Future<void> delete() async {}
}
