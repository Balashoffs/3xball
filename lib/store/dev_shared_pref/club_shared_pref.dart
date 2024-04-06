import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_x_ball/core/utils/demo_tourney_players.dart';
import 'package:three_x_ball/repository/i_app_store.dart';

import '../../model/local_store/club_sp.dart';

class DevClubSharedPref extends IClubStore{

  Future<bool> existed() async{
    return await true;
  }

  @override
  Future<ClubSP> read() async{
    return await getClub();
  }

  @override
  Future<void> create(ClubSP clubSP) async{
  }

  @override
  Future<void> update(ClubSP clubSP) async{
  }
}