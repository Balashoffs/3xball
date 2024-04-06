import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_x_ball/model/local_store/end_player_sp.dart';
import 'package:three_x_ball/repository/i_app_store.dart';

class DevEndTourneySharedPref implements IEndTourneyStore{
  static const String key = 'end';
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<bool> existed() async{
    return await prefs.then((value) => value.containsKey(key));
  }
  @override
  Future<void> add(List<EndPlayerSP> players) async {
    final playersAsJson = players.map((e) => e.toJson()).toList();
    final String json = jsonEncode(playersAsJson);
    prefs.then((value) => value.setString(key, json));
  }

  @override
  Future<void> delete() async {
    prefs.then((value) => value.remove(key));
  }

  @override
  Future<List<EndPlayerSP>> read() async{
    String? json =
        await prefs.then((value) => value.getString(key));
    if (json == null) {
      return [];
    }
    List<dynamic> playersAsJson = jsonDecode(json);
    return playersAsJson.map((e) => EndPlayerSP.fromJson(e)).toList();
  }

  @override
  Future<void> update(List<EndPlayerSP> players) async{
    final playersAsJson = players.map((e) => e.toJson()).toList();
    final String json = jsonEncode(playersAsJson);
    prefs.then((value) => value.remove(key));
    prefs.then((value) => value.setString(key, json));
  }

}