import 'package:flutter/material.dart';
import 'package:rf_core/micro_match/micro_match.dart';
import 'package:three_x_ball/features/between_match/model/model.dart';

extension MicroMatchToTeamPlayer on MicroMatch {
  List<TeamPlayerDM> toTeamPlayerList() {
    List<TeamPlayerDM> home = homeTriple.players
        .map((e) => TeamPlayerDM(
            firstName: e.getUser().getFirstName(),
            lastName: e.getUser().getLastName(),
            score: '${e.getScore()}',
            tileColor: Colors.white))
        .toList();
    List<TeamPlayerDM> away = awayTriple.players
        .map((e) => TeamPlayerDM(
        firstName: e.getUser().getFirstName(),
        lastName: e.getUser().getLastName(),
            score: '${e.getScore()}',
            tileColor: Colors.white))
        .toList();

    return [...home,...away];
  }
}
