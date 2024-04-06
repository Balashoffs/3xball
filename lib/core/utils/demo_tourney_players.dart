import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:three_x_ball/mapper/user_mapper.dart';
import 'package:three_x_ball/model/domain/user_domain.dart';
import 'package:three_x_ball/model/local_store/club_sp.dart';
import 'package:three_x_ball/model/local_store/manager_sp.dart';
import 'package:three_x_ball/model/local_store/user_sp.dart';
import 'package:uuid/uuid.dart';

import '../../model/domain/domain.dart';

Future<String> loadAsset() async {
  return rootBundle.loadString('assets/data.json');
}

Future<List<UserDM>> getUsers() async {
    String jsonOdData = await loadAsset();
    Iterable<dynamic> l = json.decode(jsonOdData) as List;
    List<UserSP> users =
        List<UserSP>.from(l.map((player) => UserSP.fromJson(player)));
    return users.map((e) => e.toDomain()).toList();
  }

Future<ClubSP> getClub() async {
  return ClubSP(
    clubName: 'Спартак',
    cityName: 'Москва',
    countryName: 'Россия',
    clubPhoto: '',
  );
}

Future<ManagerSP> getManager() async {
  return ManagerSP(
    birthday: '2000-12-12',
    id: Uuid().v4(),
    phoneNumber: '+71234567896',
    userFirstName: 'Александр',
    userLastName: 'Балашов',
    rate: 2000,
    totalGames: 0,
    totalPlayers: 0,
    photo64: '',
  );
}
