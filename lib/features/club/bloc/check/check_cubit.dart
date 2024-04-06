import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:three_x_ball/model/domain/app_domain.dart';
import 'package:three_x_ball/model/domain/club_domain.dart';
import 'package:three_x_ball/model/domain/manager_domain.dart';
import 'package:three_x_ball/model/local_store/club_sp.dart';
import 'package:three_x_ball/model/local_store/manager_sp.dart';
import 'package:three_x_ball/repository/app_repository.dart';
import 'package:uuid/uuid.dart';

part 'check_state.dart';

class CheckCubit extends Cubit<CheckState> {
  CheckCubit({required this.appRepository})
      : super(const CheckState(
          status: CheckStatus.idle,
        ));

  final AppRepository appRepository;

  Future<void> checkClub() async {

    ClubDomain club = await appRepository.readClub();
    if (club.clubName.isEmpty ) {
      emit(const CheckState(
        status: CheckStatus.failed,
      ));
    } else {
      ManagerDomain manager = await appRepository.readManager();
      AppDomain appDomain = AppDomain(manager: manager, club: club);
      emit(CheckState(status: CheckStatus.created, appDomain: appDomain));
    }
  }
}
