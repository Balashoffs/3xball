import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_x_ball/model/local_store/player_sp.dart';
import 'package:three_x_ball/repository/i_app_store.dart';

class DevSetupTourneySharedPref implements ISetupTourneyStore {
  static const String setupTourneyKey = 'setup_tourney';
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Future<void> add(List<PlayerSP> players) async{
    final playersAsJson = players.map((e) => e.toJson()).toList();
    final String json = jsonEncode(playersAsJson);
    prefs.then((value) => value.setString(setupTourneyKey, json));
  }

  @override
  Future<void> delete() async{
    prefs.then((value) => value.remove(setupTourneyKey));
  }

  @override
  Future<List<PlayerSP>> read() async {
    String? json =
        await prefs.then((value) => value.getString(setupTourneyKey));
    if (json == null) {
      return [];
    }
    List<dynamic> playersAsJson = jsonDecode(json);
    return playersAsJson.map((e) => PlayerSP.fromJson(e)).toList();
  }

  @override
  Future<void> update(List<PlayerSP> players) async{
    final playersAsJson = players.map((e) => e.toJson()).toList();
    final String json = jsonEncode(playersAsJson);
    prefs.then((value) => value.remove(setupTourneyKey));
    prefs.then((value) => value.setString(setupTourneyKey, json));
  }
}
