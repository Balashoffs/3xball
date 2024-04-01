import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:three_x_ball/model/domain/app_domain.dart';
import 'package:three_x_ball/model/domain/club_domain.dart';

import '../../../../../repository/app_repository.dart';

part 'club_state.dart';

class ClubCubit extends Cubit<ClubState> {
  ClubCubit({required this.repository}) : super(const ClubState());

  Future<void> init() async{
    ClubDomain clubDomain = await repository.readClub();
    if(clubDomain.clubName.isNotEmpty){
      emit(ClubState(clubDomain: clubDomain));
    }
  }

  final AppRepository repository;
}
