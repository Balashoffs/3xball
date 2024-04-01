import 'dart:typed_data';

import 'package:flutter/material.dart';

Image selectAvatarImage({required Uint8List? userAvatar, bool isSelected = false}) {
  return (userAvatar != null && userAvatar.isNotEmpty)
      ? Image.memory(
    userAvatar,
  )
      : isSelected
      ? selectedAvatar
      : defaultAvatar;
}

Image get defaultAvatar => Image.asset(
  'assets/club_lobby/default_player_avatar.png',
  width: 30.0,
  height: 30.0,
);

Image get selectedAvatar => Image.asset(
  'assets/setup_tourney/selected_player_avatar.png',
);