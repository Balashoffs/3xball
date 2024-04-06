import 'package:three_x_ball/repository/i_app_store.dart';

import '../store/dev_shared_pref/dev_shared_pref.dart';
import '../store/shared_pref/shared_pref.dart';

abstract class AppStore{
  late final IClubStore clubStore;
  late final IManagerStore managerStore;
  late final IPlayersStore playersStore;
  late final ISetupTourneyStore tourneyStore;
  late final IEndTourneyStore endTourneyStore;
}

class ProdAppStore extends AppStore{
  ProdAppStore(){
    clubStore =  ClubSharedPref();
    managerStore = ManagerSharedPref();
    playersStore = PlayersSharedPref();
    tourneyStore = SetupTourneySharedPref();
    endTourneyStore = EndTourneySharedPref();
  }
}

class DevAppStore extends AppStore{
  DevAppStore(){
    clubStore =  DevClubSharedPref();
    managerStore = DevManagerSharedPref();
    playersStore = DevPlayersSharedPref();
    tourneyStore = DevSetupTourneySharedPref();
    endTourneyStore = DevEndTourneySharedPref();
  }
}