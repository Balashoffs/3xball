import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:three_x_ball/mapper/user_mapper.dart';
import 'package:three_x_ball/model/domain/user_domain.dart';
import 'package:three_x_ball/model/local_store/user_sp.dart';


class DevelopDataSet {
  static Future<String> loadAsset() async {
    return rootBundle.loadString('assets/data.json');
  }

  static Future<List<UserDM>> getPlayers() async {
    String jsonOdData = await loadAsset();
    Iterable<dynamic> l = json.decode(jsonOdData) as List;
    List<UserSP> users =
        List<UserSP>.from(l.map((player) => UserSP.fromJson(player)));
    return users.map((e) => e.toDomain()).toList();
  }

}
