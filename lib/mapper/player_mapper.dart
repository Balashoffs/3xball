import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/add_player/bloc/add_player_cubit.dart';
import 'package:three_x_ball/features/edit_player/bloc/edit_player_cubit.dart';
import 'package:three_x_ball/mapper/user_mapper.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:three_x_ball/model/local_store/end_player_sp.dart';
import 'package:three_x_ball/model/local_store/player_sp.dart';
import 'package:three_x_ball/model/rf_core/player_rf.dart';
import 'package:uuid/uuid.dart';



extension PlayerFromAddState on AddPlayerState {
  UserDM toPlayer() {
    String userLastName = userFI.value.split(' ')[1];
    String firstName = userFI.value.split(' ')[0];
    return UserDM(
      id: const Uuid().v1(),
      userFirstName: firstName,
      userLastName: userLastName,
      birthday: convertDate(birthday.value),
      phoneNumber: phoneNumber.value,
    );
  }
}

extension PlayerFromEditState on EditPlayerState {
  UserDM toPlayer(String id) {
    String userLastName = userFI.value.split(' ')[1];
    String firstName = userFI.value.split(' ')[0];
    return UserDM(
      id: id,
      userFirstName: firstName,
      userLastName: userLastName,
      birthday: convertDate(birthday.value),
      phoneNumber: phoneNumber.value,
    );
  }
}

extension PlayerFromSP on PlayerSP {
  UserDM toPlayerD() {
    Uint8List? bytes = photo64.isEmpty ? Uint8List(0) : base64Decode(photo64);
    return UserDM(
      id: id,
      userFirstName: userFirstName,
      userLastName: userLastName,
      phoneNumber: phoneNumber,
      userNick: userNick,
      totalGames: totalGames,
      rate: rate,
      userAvatar: bytes,
      birthday: birthday,
    );
  }
}

extension OnPlayerRF on PlayerRF {
  PlayerDM toPlayerDM(
    Color tileColor,
    Uint8List rawImage,
  ) {
    UserDM userDM = UserDM(
      id: getUser().getId(),
      userFirstName: getUser().getFirstName(),
      userLastName: getUser().getLastName(),
      rate: getUser().getRange(),
      userAvatar: rawImage,
    );
    return PlayerDM(
      userDM: userDM,
      tileColor: tileColor,
      score: getScore(),
      matchQnt: getMatchesQnt(),
      pos: getPos(),
    );
  }
}

extension OnPlayerDM on PlayerDM {
  PlayerRF toPlayerRF() {
    return PlayerRF(
      score: score,
      matchQnt: matchQnt,
      pos: pos,
      color: tileColor,
      user: userDM.toUserRF(),
    );
  }

  GoalAuthor toGoalAuthor() {
    return GoalAuthor(playerPos: pos, commandColor: tileColor);
  }
}

extension OnEndPlayerDM on EndPlayerDM {
  EndPlayerSP toEndPlayerSP() {
    return EndPlayerSP(
      id: id,
      userFirstName: userFirstName,
      userLastName: userLastName,
      rate: rate,
      totalGames: totalGames,
      userAvatarBase64: base64Encode(userAvatar),
      delta: delta,
      score: score,
    );
  }
}

extension OnEndPlayerSP on EndPlayerSP {
  EndPlayerDM toEndPlayerDM() {
    return EndPlayerDM(
      id: id,
      userFirstName: userFirstName,
      userLastName: userLastName,
      rate: rate,
      totalGames: totalGames,
      userAvatar: base64Decode(userAvatarBase64),
      delta: delta,
      score: score,
    );
  }
}
