import 'package:flutter/material.dart';
import 'package:three_x_ball/model/domain/user_domain.dart';

class PlayerDM implements Comparable<PlayerDM>{
  final UserDM userDM;
  final Color? tileColor;
  final int score;
  final int matchQnt;
  final int pos;


  PlayerDM({
    required this.userDM,
    this.tileColor,
    required this.score,
    required this.matchQnt,
    required this.pos,
  });

  @override
  int compareTo(PlayerDM other) {
    if (score > other.score) {
      return -1;
    } else if (score < other.score) {
      return 1;
    }

    if (matchQnt > other.matchQnt) {
      return -1;
    } else if (matchQnt < other.matchQnt) {
      return 1;
    }
    int lastNameCompare = userDM.userLastName.compareTo(other.userDM.userLastName);
    if (lastNameCompare == 0) {
      return userDM.userFirstName.compareTo(other.userDM.userFirstName);
    }
    return lastNameCompare;
  }
}
