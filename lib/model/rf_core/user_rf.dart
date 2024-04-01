
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rf_core/micro_match/micro_match.dart';

class UserRF implements IUser {
  final String _fistName;
  final String _lastName;
  final String _id;
  final int _range;
  final Uint8List? rawImage;




  Image selectAvatar({bool isSelected = false}) {
    return !(rawImage == null || rawImage!.isEmpty)
        ? Image.memory(
      rawImage!,
    )
        : isSelected
        ? selectedAvatar
        : defaultAvatar;
  }

  static Image get defaultAvatar => Image.asset(
    'assets/club_lobby/default_player_avatar.png',
    width: 50.0,
    height: 50.0,
  );

  static Image get selectedAvatar => Image.asset(
    'assets/setup_tourney/selected_player_avatar.png',
  );

  @override
  IUser copyWith({
    String? id,
    String? lastName,
    String? firstName,
    int? rate,
  }) {
    return UserRF(
      firstName: firstName ?? _fistName,
      lastName: lastName ?? _lastName,
      id: id ?? _id,
      range: rate ?? _range,
    );
  }

  UserRF copyFullWith({
    String? id,
    String? lastName,
    String? firstName,
    int? rate,
    Uint8List? avatar,
  }) {
    return UserRF(
      firstName: firstName ?? _fistName,
      lastName: lastName ?? _lastName,
      id: id ?? _id,
      range: rate ?? _range,
      rawImage: avatar ?? this.rawImage,
    );
  }

  @override
  String getFirstName() {
    return _fistName;
  }

  @override
  String getId() {
    return _id;
  }

  @override
  String getLastName() {
    return _lastName;
  }

  @override
  int getRange() {
    return _range;
  }

  UserRF({
    this.rawImage,
    required String firstName,
    required String lastName,
    required String id,
    required int range,
  })  : _fistName = firstName,
        _lastName = lastName,
        _id = id,
        _range = range;
}
