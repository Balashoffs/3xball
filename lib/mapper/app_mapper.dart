import 'dart:convert';
import 'dart:typed_data';

import 'package:three_x_ball/core/utils/utils.dart';
import 'package:three_x_ball/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:three_x_ball/model/domain/domain.dart';
import 'package:three_x_ball/model/local_store/club_sp.dart';
import 'package:three_x_ball/model/local_store/manager_sp.dart';


extension ToClubFromSighUpState on SignUpState {
  ClubDomain toClubD() {
    return ClubDomain(
      clubName: clubName.value,
      cityName: cityName.value,
      countryName: countryName.value,
      clubPhoto: '',
    );
  }
}

extension ToClubSP on SignUpState {
  ClubSP toClubSP() {
    return ClubSP(
      clubPhoto: '',
      clubName: clubName.value,
      cityName: cityName.value,
      countryName: countryName.value,
    );
  }
}

extension ToManagerSP on SignUpState {
  ManagerSP toManagerSP(String id) {
    String userLastName = userFI.value.split(' ')[1];
    String userFirstName = userFI.value.split(' ')[0];
    return ManagerSP.onlyUser(
      id: id,
      phoneNumber: phoneNumber.value,
      birthday: convertDate(birthday.value),
        userFirstName: userFirstName,
        userLastName: userLastName,
    );
  }
}

extension ToClubDomain on SignUpState {
  ClubDomain toClubDomain() {
    return ClubDomain(
      clubName: clubName.value,
      cityName: cityName.value,
      countryName: countryName.value,
    );
  }
}

extension ToManagerDomain on SignUpState {
  ManagerDomain toManagerDomain(String id) {
    String userLastName = userFI.value.split(' ')[1];
    String userFirstName = userFI.value.split(' ')[0];
    return ManagerDomain(
      id: id,
      phoneNumber: phoneNumber.value,
      birthday: convertDate(birthday.value),
      userFirstName: userFirstName,
      userLastName: userLastName,
    );
  }
}
//
extension ToClubD on ClubSP {
  ClubDomain toClubD() {
    return ClubDomain(
      clubName: clubName,
      cityName: cityName,
      countryName: countryName,
      clubPhoto: clubPhoto
    );
  }
}

extension ToManagerD on ManagerSP {
  ManagerDomain toManagerD() {
    Uint8List? bytes;
    if(photo64.isNotEmpty) bytes = base64Decode(photo64);
    return ManagerDomain(
      id: id,
      userFirstName: userFirstName,
      userLastName: userLastName,
      birthday : birthday,
      phoneNumber : phoneNumber,
      photoAsBytes : bytes,
      rate: rate,
      totalGames: totalGames,
      totalPlayers : totalPlayers,
    );
  }
}
