import 'package:flutter/material.dart';
import 'package:rf_core/micro_match/micro_match.dart';
import 'package:rf_core/model/player_fee.dart';

class PlayerRF implements IPlayer, Comparable<PlayerRF> {
  final IUser _user;
  final int _pos;
  final int _matchQnt;
  final int _score;
  final int? _delta;
  final Color? color;
  final PlayerFee? _playerFee;

  @override
  int getDeltaRange() {
    return _delta ?? 0;
  }

  @override
  int getMatchesQnt() {
    return _matchQnt;
  }

  @override
  PlayerFee? getPlayerFee() {
    return _playerFee;
  }

  @override
  int getPos() {
    return _pos;
  }

  @override
  int getScore() {
    return _score;
  }

  @override
  IUser getUser() {
    return _user;
  }

  PlayerRF copyFullWith({
    Color? color,
    IUser? user,
    int? pos,
    int? matchQnt,
    int? score,
    int? delta,
  }) {
    return PlayerRF(
      user: user ?? _user,
      pos: pos ?? _pos,
      matchQnt: matchQnt ?? _matchQnt,
      score: score ?? _score,
      delta: delta ?? _delta,
      color: color ?? this.color,
    );
  }

  const PlayerRF({
    this.color,
    required IUser user,
    required int pos,
    required int matchQnt,
    required int score,
    PlayerFee? playerFee,
    int? delta,
  })  : _user = user,
        _pos = pos,
        _matchQnt = matchQnt,
        _score = score,
        _playerFee = playerFee,
        _delta = delta;

  @override
  IPlayer copyWith({
    IUser? user,
    PlayerFee? playerFee,
    int? pos,
    int? matchesQnt,
    int? score,
    int? delta,
  }) {
    return PlayerRF(
      user: user ?? _user,
      pos: pos ?? _pos,
      matchQnt: matchesQnt ?? _matchQnt,
      score: score ?? _score,
      delta: delta ?? _delta,
      playerFee: playerFee ?? _playerFee,
    );
  }

  @override
  String toString() {
    return 'PlayerRF{_user: $_user, _pos: $_pos, _matchQnt: $_matchQnt, _score: $_score, _delta: $_delta, color: $color}';
  }

  @override
  int compareTo(PlayerRF other) {
    int matchQnt =  _matchQnt.compareTo(other.getMatchesQnt());
    int scoreQnt = _score.compareTo(other._score);
    int lastName = _user.getLastName().compareTo(other.getUser().getLastName());
    int firstName = _user.getFirstName().compareTo(other.getUser().getFirstName());
    return matchQnt.compareTo(scoreQnt.compareTo(lastName.compareTo(firstName)));
  }
}

// @override
// int compareTo(EndPlayerDM other) {
//   if (delta < other.delta) {
//     return 1;
//   } else if (delta > other.delta) {
//     return -1;
//   } else {
//     if (rate < other.rate) {
//       return 1;
//     } else if (rate > other.rate) {
//       return -1;
//     } else {
//       int lastNameCompare = userLastName.compareTo(other.userLastName);
//       if (lastNameCompare == 0) {
//         return userFirstName.compareTo(other.userFirstName);
//       }
//       return lastNameCompare;
//     }
//   }
// }
