import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:three_x_ball/core/utils/utils.dart';


class UserDM extends Equatable implements Comparable<UserDM>{
  final String id;
  final String userFirstName;
  final String userLastName;
  final String? userNick;
  final String? birthday;
  final int _age;
  final String? phoneNumber;
  final int rate;
  final int totalGames;
  final Uint8List? userAvatar;
  final String? userAvatarString;
  final bool inSelected;

  UserDM({
    required this.id,
    required this.userFirstName,
    required this.userLastName,
    this.birthday,
    this.phoneNumber,
    this.userNick,
    this.rate = 2000,
    this.totalGames = 0,
    this.userAvatar,
    this.inSelected = false,
    this.userAvatarString,
  }) : _age = _setAge(birthday);

  int get age => _age;

  String get fullName => '$userLastName $userFirstName';

  UserDM copyWith({
    String? userFirstName,
    String? userLastName,
    String? userNick,
    String? birthday,
    String? phoneNumber,
    int? rate,
    int? totalGames,
    Uint8List? userAvatar,
    bool? inSelected,
    String? userAvatarString,
    Image? avatar,
  }) {
    return UserDM(
      id: id,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      birthday: birthday ?? this.birthday,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userAvatar: userAvatar ?? userAvatar,
      rate: rate ?? this.rate,
      totalGames: totalGames ?? this.totalGames,
      userNick: userNick ?? this.userNick,
      inSelected: inSelected ?? this.inSelected,
      userAvatarString: userAvatarString ?? this.userAvatarString,
    );
  }

  static int _setAge(String? birthday) {
    if(birthday == null) return 0;
    final dateNow = DateTime.now();
    final dateUser = DateTime.parse(birthday);
    final inDay = dateNow.difference(dateUser).inDays;
    return inDay ~/ 365;
  }

  Image selectAvatar(){
    return selectAvatarImage(userAvatar:  userAvatar);
  }

  @override
  List<Object> get props {
    return [
      userLastName,
      userFirstName,
      age,
      inSelected,
    ];
  }

  @override
  int compareTo(UserDM other) {
    if (rate > other.rate) {
      return -1;
    } else if (rate < other.rate) {
      return 1;
    } else {
      int lastNameCompare = userLastName.compareTo(other.userLastName);
      if (lastNameCompare == 0) {
        return userFirstName.compareTo(other.userFirstName);
      }
      return lastNameCompare;
    }
  }
}
