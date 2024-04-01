import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rf_core/judge.dart';
import 'package:rf_core/micro_match/micro_match.dart';
import 'package:three_x_ball/mapper/user_mapper.dart';
import 'package:three_x_ball/model/domain/after_tourney_player_dm.dart';
import 'package:three_x_ball/model/domain/goal_author.dart';
import 'package:three_x_ball/model/rf_core/player_rf.dart';
import 'package:three_x_ball/repository/app_repository.dart';

import '../model/domain/user_domain.dart';

class MatchRepository {
  MatchRepository({
    required this.appRepository,
  });

  final AppRepository appRepository;
  MicroMatch? microMatch;
  Judge? judge;
  final List<int> matchResult = [];
  List<Color> playerTileColors = [];
  List<PlayerRF> tourneyPlayers = [];
  List<PlayerRF> matchPlayers = [];
  Map<String, Uint8List> userPhotos = {};
  GoalAuthor? _goalAuthor;

  Future<void> init() async {
    matchResult.add(0);
    matchResult.add(0);
    playerTileColors.addAll(appRepository.readPlayerTileColors());
    List<UserDM> players = await appRepository.readMatchPlayers();
    for (int i = 0; i < players.length; i++) {
      userPhotos.putIfAbsent(
          players[i].id, () => players[i].userAvatar ?? Uint8List(0));
      tourneyPlayers.add(
        PlayerRF(
          user: players[i].toUserRF(),
          delta: 0,
          score: 0,
          matchQnt: 0,
          pos: i + 1,
        ),
      );
    }
    judge = Judge(players: tourneyPlayers);
  }

  List<List<int>> microMatchResults = [
    [2, 0],
    [1, 2],
    [1, 1],
    [2, 0],
    [0, 0],
    [1, 2],
    [2, 1],
    [1, 2],
    [0, 2],
    [1, 2]
  ];

  Future<void> demoInit() async {
    await init();
    for (var result in microMatchResults) {
      MicroMatch? mm = judge?.getNextMicroMatchPair();
      mm?.setResult(result[0], result[1]);
      if (mm == null) break;
      judge?.updatePlayerPointAfterMatch(mm);
    }
    microMatch = null;
  }

  Uint8List getUserPhoto(String id) {
    return userPhotos[id] ?? Uint8List(0);
  }

  void setMatchPlayers() {
    matchPlayers.clear();
    if (microMatch == null) {
      return;
    }

    List<PlayerRF>? home = microMatch?.homeTriple.players
            .map(
              (e) => PlayerRF(
                user: e.getUser(),
                pos: e.getPos(),
                matchQnt: e.getMatchesQnt(),
                score: e.getScore(),
                color: playerTileColors[0],
              ),
            )
            .toList() ??
        [];
    List<PlayerRF>? away = microMatch?.awayTriple.players
            .map((e) => PlayerRF(
                user: e.getUser(),
                pos: e.getPos(),
                matchQnt: e.getMatchesQnt(),
                score: e.getScore(),
                color: playerTileColors[1]))
            .toList() ??
        [];

    for (int i = 0; i < 6; i++) {
      int pos = i ~/ 2;
      if (i % 2 == 0) {
        matchPlayers.add(home[pos]);
      } else {
        matchPlayers.add(away[pos]);
      }
    }
  }

  List<PlayerRF> getTourneyPlayers() => tourneyPlayers;

  int getMatchItem() {
    return microMatch!.matchPos ?? 1;
  }

  List<int> updateMatchScore() {
    if (_goalAuthor != null) {
      int pos = playerTileColors
          .indexWhere((element) => element == _goalAuthor!.commandColor);
      int score = matchResult[pos] + 1;
      matchResult[pos] = score;
      _goalAuthor = null;
    }
    return matchResult;
  }

  void addGoalAuthor(GoalAuthor? author) {
    _goalAuthor = author;
  }

  int nextMatch() {
    if (microMatch != null) {
      microMatch?.setResult(matchResult[0], matchResult[1]);
      Map<int, int> scores =
          judge?.updatePlayerPointAfterMatch(microMatch!) ?? {};
      Set<String> ids = _getIdSet();
      List<PlayerRF> updated = tourneyPlayers.map((e) {
        int qnt = ids.contains(e.getUser().getId())
            ? e.getMatchesQnt() + 1
            : e.getMatchesQnt();
        return e.copyWith(score: scores[e.getPos()], matchesQnt: qnt)
            as PlayerRF;
      }).toList();

      // updated.sort();

      tourneyPlayers.clear();
      tourneyPlayers.addAll(updated);
      matchResult.clear();
      matchResult.addAll([0, 0]);
    }
    microMatch = judge?.getNextMicroMatchPair();
    return microMatch?.matchPos ?? 0;
  }

  Set<String> _getIdSet() {
    Set<String>? aways =
        microMatch?.awayTriple.players.map((e) => e.getUser().getId()).toSet();
    Set<String>? homes =
        microMatch?.homeTriple.players.map((e) => e.getUser().getId()).toSet();
    return {...aways!, ...homes!};
  }

  Future<void> endTourney() async {
    List<IPlayer> results = judge?.calculateResults() ?? [];
    List<UserDM> playersDM = await appRepository.readMatchPlayers();

    List<EndPlayerDM> players = results.map((e) {
      UserDM find =
          playersDM.where((element) => element.id == e.getUser().getId()).first;
      return e.getUser().toEndPlayerDM(
            find.copyWith(totalGames: find.totalGames),
            e.getDeltaRange(),
            e.getScore(),
          );
    }).toList();
    await appRepository.deleteEndTourneyPlayer();
    await appRepository.addEndTourneyPlayers(players);

    reset();
  }

  void reset() {
    microMatch = null;
    judge = null;
    matchResult.clear();
    playerTileColors.clear();
    tourneyPlayers.clear();
    matchPlayers.clear();
    userPhotos.clear();
  }
}
