import 'package:three_x_ball/repository/i_app_store.dart';

import '../store/shared_pref/shared_pref.dart';

class AppStore{
  late final IClubStore clubStore;
  late final IManagerStore managerStore;
  late final IPlayersStore playersStore;
  late final ISetupTourneyStore tourneyStore;
  late final IEndTourneyStore endTourneyStore;

  AppStore(){
    clubStore =  ClubSharedPref();
    managerStore = ManagerSharedPref();
    playersStore = PlayersSharedPref();
    tourneyStore = SetupTourneySharedPref();
    endTourneyStore = EndTourneySharedPref();
  }
}