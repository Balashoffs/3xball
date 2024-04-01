import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_x_ball/mapper/player_mapper.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:three_x_ball/repository/match_repository.dart';

part 'between_match_state.dart';

class BetweenMatchCubit extends Cubit<BetweenMatchState> {
  BetweenMatchCubit({
    required this.matchRepository,
  }) : super(
          const BetweenMatchState(
            status: BetweenMatchStatus.idle,
          ),
        );

  final MatchRepository matchRepository;

  void init() async {
    await matchRepository.init();
    int matchPos = matchRepository.nextMatch();
    matchRepository.setMatchPlayers();
    List<PlayerDM> matchPlayers = matchRepository.matchPlayers
        .map(
          (e) => e.toPlayerDM(
            e.color ?? Colors.white,
            matchRepository.getUserPhoto(e.getUser().getId()),
          ),
        )
        .toList();

    emit(BetweenMatchState(
      status: BetweenMatchStatus.start,
      matchPlayers: matchPlayers,
      matchPos: matchPos,
    ));
  }

  void nextMatch() async {
    int matchPos = matchRepository.nextMatch();
    matchRepository.setMatchPlayers();
    List<PlayerDM> tourneyPlayers = matchRepository
        .getTourneyPlayers()
        .map((e) => e.toPlayerDM(e.color ?? Colors.white,
            matchRepository.getUserPhoto(e.getUser().getId())))
        .toList();
    tourneyPlayers.sort();
    List<PlayerDM> matchPlayers = matchRepository.matchPlayers
        .map((e) => e.toPlayerDM(e.color ?? Colors.white,
            matchRepository.getUserPhoto(e.getUser().getId())))
        .toList();
    String matchResult = await SharedPreferences.getInstance()
        .then((value) => value.getString('match_result') ?? '');
    if (matchPlayers.isNotEmpty) {
      emit(
        BetweenMatchState(
          status: BetweenMatchStatus.next,
          tourneyPlayers: tourneyPlayers,
          matchPlayers: matchPlayers,
          matchPos: matchPos,
          matchResult: matchResult
        ),
      );
    } else {
      await matchRepository.endTourney();
      await SharedPreferences.getInstance().then((value) => value.remove('match_result'));
      emit(
        BetweenMatchState(
          status: BetweenMatchStatus.finish,
          tourneyPlayers: tourneyPlayers,
          matchPos: tourneyPlayers.length,
          matchResult: matchResult
        ),
      );
    }
  }
}
