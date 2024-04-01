import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_x_ball/repository/i_app_store.dart';

import '../../model/local_store/club_sp.dart';

class ClubSharedPref extends IClubStore{


  static const String key = 'club';
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<bool> existed() async{
    return await prefs.then((value) => value.containsKey(key));
  }

  @override
  Future<ClubSP> read() async{
    String? clubAsJson =  await prefs.then((value) => value.getString(key));
    if(clubAsJson != null){
      return ClubSP.fromJson(jsonDecode(clubAsJson));
    }
    return ClubSP.empty();
  }

  @override
  Future<void> create(ClubSP clubSP) async{
    String clubAsJson = jsonEncode(clubSP.toJson());
    await prefs.then((value) => value.setString(key, clubAsJson));
  }

  @override
  Future<void> update(ClubSP clubSP) async{
    String clubAsJson = jsonEncode(clubSP.toJson());
    await prefs.then((value){
      value.remove(key);
      value.setString(key, clubAsJson);
    });
  }
}