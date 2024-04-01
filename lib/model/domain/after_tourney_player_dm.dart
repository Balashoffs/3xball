import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:three_x_ball/core/utils/utils.dart';

class EndPlayerDM implements Comparable<EndPlayerDM> {
  final String id;
  final String userFirstName;
  final String userLastName;
  final int rate;
  final int totalGames;
  final Uint8List userAvatar;
  final int delta;
  final int score;

  Image selectAvatar() {
    return selectAvatarImage(userAvatar: userAvatar);
  }

  const EndPlayerDM({
    required this.id,
    required this.userFirstName,
    required this.userLastName,
    required this.rate,
    required this.totalGames,
    required this.userAvatar,
    required this.delta,
    required this.score,
  });

  @override
  int compareTo(EndPlayerDM other) {
    if (delta < other.delta) {
      return 1;
    } else if (delta > other.delta) {
      return -1;
    } else {
      if (rate < other.rate) {
        return 1;
      } else if (rate > other.rate) {
        return -1;
      } else {
        int lastNameCompare = userLastName.compareTo(other.userLastName);
        if (lastNameCompare == 0) {
          return userFirstName.compareTo(other.userFirstName);
        }
        return lastNameCompare;
      }
    }
  }
}
