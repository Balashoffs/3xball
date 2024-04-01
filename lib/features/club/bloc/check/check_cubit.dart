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
      if (kDebugMode || kReleaseMode) {
        print('kDebugMode');
        ClubDomain club = ClubDomain(
          clubName: 'Спартак',
          cityName: 'Москва',
          countryName: 'Россия',
        );
        ManagerDomain manager = ManagerDomain(
          birthday: '2000-12-12',
          id: Uuid().v4(),
          phoneNumber: '+71234567896',
          userFirstName: 'Александр',
          userLastName: 'Балашов',
          rate: 2000,
          totalGames: 0,
          totalPlayers: 0,
        );

        await appRepository.createClub(ClubSP(
            clubName: club.clubName,
            cityName: club.cityName,
            countryName: club.countryName,
            clubPhoto: club.clubPhoto));
        await appRepository.createManager(ManagerSP(
          rate: manager.rate,
          totalGames: manager.totalGames,
          totalPlayers: manager.totalPlayers,
          id: manager.id,
          userFirstName: manager.userFirstName,
          userLastName: manager.userLastName,
          birthday: manager.birthday,
          phoneNumber: manager.phoneNumber,
          photo64: '',
        ));
        AppDomain appDomain = AppDomain(manager: manager, club: club);
        emit(CheckState(status: CheckStatus.created, appDomain: appDomain));
      }
      else{
        emit(const CheckState(
          status: CheckStatus.failed,
        ));
      }
    } else {
      ManagerDomain manager = await appRepository.readManager();
      AppDomain appDomain = AppDomain(manager: manager, club: club);
      emit(CheckState(status: CheckStatus.created, appDomain: appDomain));
    }
  }
}
