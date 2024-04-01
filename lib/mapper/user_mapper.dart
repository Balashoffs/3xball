import 'dart:convert';
import 'dart:typed_data';

import 'package:rf_core/micro_match/micro_match.dart';
import 'package:three_x_ball/model/domain/after_tourney_player_dm.dart';
import 'package:three_x_ball/model/local_store/user_sp.dart';

import '../model/domain/user_domain.dart';
import '../model/local_store/player_sp.dart';
import '../model/rf_core/user_rf.dart';

extension UserToDomain on UserSP {
  UserDM toDomain() {
    return UserDM(
        id: id,
        userFirstName: userFirstName,
        userLastName: userLastName,
        birthday: birthday,
        userAvatarString: photoLink,
        phoneNumber: phoneNumber);
  }

  UserRF toUserRF([int rate = 0]) {
    return UserRF(
        firstName: userFirstName, lastName: userLastName, id: id, range: rate);
  }
}

extension OnUserDM on UserDM {
  PlayerSP toPlayerSP() {
    String photo64 = userAvatar == null ? '' : base64Encode(userAvatar!);
    return PlayerSP(
      id: id,
      userFirstName: userFirstName,
      userLastName: userLastName,
      birthday: birthday ?? '',
      phoneNumber: phoneNumber ?? '',
      totalGames: totalGames,
      rate: rate,
      photo64: photo64,
    );
  }

  UserRF toUserRF() {
    return UserRF(
      lastName: userLastName,
      firstName: userFirstName,
      rawImage: userAvatar,
      id: id,
      range: rate,
    );
  }
}

extension OnIUser on IUser {
  UserDM toUserDM(UserDM userDM) {
    return UserDM(
      id: getId(),
      userFirstName: getFirstName(),
      userLastName: getLastName(),
      rate: getRange(),
      userAvatar: userDM.userAvatar,
      totalGames: userDM.totalGames,
      birthday: userDM.birthday,
      phoneNumber: userDM.phoneNumber,
    );
  }

  EndPlayerDM toEndPlayerDM(UserDM userDM, int delta, int score) {
    return EndPlayerDM(
      id: getId(),
      userFirstName: getFirstName(),
      userLastName: getLastName(),
      rate: getRange(),
      totalGames: userDM.totalGames,
      userAvatar: userDM.userAvatar ?? Uint8List(0),
      delta: delta,
      score: score,
    );
  }
}
