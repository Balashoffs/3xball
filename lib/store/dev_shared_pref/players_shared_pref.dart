import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_x_ball/core/utils/demo_tourney_players.dart';
import 'package:three_x_ball/mapper/user_mapper.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:three_x_ball/model/local_store/player_sp.dart';
import 'package:three_x_ball/repository/i_app_store.dart';

class DevPlayersSharedPref extends IPlayersStore {
  static const String key = 'players';
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Future<List<PlayerSP>> read() async {
    String? json = await prefs.then((value) => value.getString(key));
    if (json == null) {
     List<UserDM> usersDM = await getUsers();
     List<PlayerSP> playersSP = usersDM.map((e) => e.toPlayerSP()).toList();
     add(playersSP);
     return playersSP;
    }
    List<dynamic> playersAsJson = jsonDecode(json!);
    return playersAsJson.map((e) => PlayerSP.fromJson(e)).toList();
  }

  @override
  Future<void> update(List<PlayerSP> players) async {
    String? json = await prefs.then((value) => value.getString(key));
    if (json != null) {
      List<dynamic> playersAsDynamic = jsonDecode(json);
      List<PlayerSP> foundPlayers =
          playersAsDynamic.map((e) => PlayerSP.fromJson(e)).toList();
      Set<String> ids = players.map((e) => e.id).toSet();
      foundPlayers.removeWhere((element) => ids.contains(element.id));
      foundPlayers.addAll(players);

      List<dynamic> playersAsJson = foundPlayers.map((e) => e.toJson()).toList();
      json = jsonEncode(playersAsJson);
      await prefs.then((value) => value.setString(key, json!));
    }
  }

  @override
  Future<void> add(List<PlayerSP> players) async {
    String? json = await prefs.then((value) => value.getString(key));
    if (json == null) {
      var playerAsMap = players.map((e) => e.toJson()).toList();
      json = jsonEncode(playerAsMap);
    } else {
      List<dynamic> playersAsDynamic = jsonDecode(json);
      List<PlayerSP> foundPlayers =
          playersAsDynamic.map((e) => PlayerSP.fromJson(e)).toList();
      foundPlayers.addAll(players);
      List<dynamic> playersAsJson =
          foundPlayers.map((e) => e.toJson()).toList();
      json = jsonEncode(playersAsJson);
    }
    await prefs.then((value) => value.setString(key, json!));
  }

  @override
  Future<void> delete() async {
    await prefs.then((value) => value.remove(key));
  }
}
