import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:three_x_ball/mapper/player_mapper.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:three_x_ball/repository/match_repository.dart';

part 'match_state.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit({required MatchRepository matchRepository})
      : _matchRepository = matchRepository,
        super(const MatchState());

  final MatchRepository _matchRepository;

  void init() {
    List<PlayerDM> matchPlayers = _matchRepository.matchPlayers
        .map((e) =>
        e.toPlayerDM(
            e.color ?? Colors.white,
            _matchRepository.getUserPhoto(
              e.getUser().getId(),
            )))
        .toList();
    int matchItem = _matchRepository.getMatchItem();

    emit(state.copyWith(
        status: MatchStatus.ready,
        matchItem: matchItem,
        matchPlayers: matchPlayers));
  }

  void onPaused(bool isPaused) {
    if (isPaused) {
      emit(state.copyWith(
        status: MatchStatus.selecting,
      ));
    } else {
      emit(state.copyWith(
        status: MatchStatus.ready,
      ));
    }
  }

  void onSelected(PlayerDM player) {
    GoalAuthor goalAuthor = player.toGoalAuthor();
    _matchRepository.addGoalAuthor(goalAuthor);
    emit(
      state.copyWith(status: MatchStatus.selected, playerPos: player.pos),
    );
  }

  void onConfirm() async {
    List<int> matchScore = _matchRepository.updateMatchScore();
    MatchStatus status = matchScore
        .where((element) => element == 2)
        .isNotEmpty
        ? MatchStatus.end
        : MatchStatus.idle;

    emit(
      state.copyWith(status: status, matchScore: matchScore, playerPos: -1),
    );
  }

  void onFinish() async {
    emit(state.copyWith(
      status: MatchStatus.cancel,
    ));
  }

  void onClosed() async {
    _matchRepository.addGoalAuthor(null);
    emit(
      state.copyWith(
        status: MatchStatus.end,
        playerPos: -1,
      ),
    );
  }

  void onCancel() {
    _matchRepository.addGoalAuthor(null);
    emit(
      state.copyWith(
        status: MatchStatus.end,
        playerPos: -1,
      ),
    );
  }

  void saveMatchResult() async {
    await SharedPreferences.getInstance().then((value) =>
        value.setString(
            'match_result', _matchRepository.matchResult.join('   :   ')));
  }
}
