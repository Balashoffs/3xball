import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:three_x_ball/repository/app_repository.dart';


part 'end_tourney_state.dart';

class EndTourneyCubit extends Cubit<EndTourneyState> {
  EndTourneyCubit({required AppRepository appRepository})
      : _appRepository = appRepository,
        super(const EndTourneyState(status: EndTourneyStatus.idle));

  final AppRepository _appRepository;

  void init() async {
    List<EndPlayerDM> updated = await _appRepository.readEndTourneyPlayers();
    updated.sort();
    emit(EndTourneyState(status: EndTourneyStatus.show, players: updated));
  }

  void updateLocalStore() async {
    Map<String, EndPlayerDM> ends = {for (var e in state.players) e.id: e};
    List<UserDM> founded = await _appRepository.readLobbyPlayers();
    founded.removeWhere((element) =>!ends.keys.contains(element.id));
    List<UserDM> updated = founded.map((e) {
      EndPlayerDM? end = ends[e.id];
      if (end != null) {
        return e.copyWith(
          rate: end.rate + end.delta,
          totalGames: end.totalGames + 1,
        );
      }
      return e.copyWith();
    }).toList();

    await _appRepository.updateLobbyPlayers(updated);
    emit(const EndTourneyState(status: EndTourneyStatus.update,));
  }
}
