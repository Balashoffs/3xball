import 'package:json_annotation/json_annotation.dart';
import 'package:three_x_ball/model/local_store/user_sp.dart';

part 'manager_sp.g.dart';

@JsonSerializable()
class ManagerSP extends UserSP {
  //Rating
  final int rate;

  //total games were played by manager
  final int totalGames;

  //total players at club;
  final int totalPlayers;

  ManagerSP({
    required this.rate,
    required this.totalGames,
    required this.totalPlayers,
    required String id,
    required String userFirstName,
    required String userLastName,
    required String birthday,
    required String phoneNumber,
    required String photo64,
  }) : super(
            id: id,
            userFirstName: userFirstName,
            userLastName: userLastName,
            birthday: birthday,
            phoneNumber: phoneNumber,
            photo64: photo64);

  factory ManagerSP.fromJson(Map<String, dynamic> json) =>
      _$ManagerSPFromJson(json);

  Map<String, dynamic> toJson() => _$ManagerSPToJson(this);

  ManagerSP.empty()
      : rate = 0,
        totalGames = 0,
        totalPlayers = 0,
        super(
            birthday: '',
            id: '',
            phoneNumber: '',
            photo64: '',
            userFirstName: '',
            userLastName: '');

  ManagerSP.onlyUser({
    required String id,
    required String userFirstName,
    required String userLastName,
    required String birthday,
    required String phoneNumber,
  })  : rate = 0,
        totalGames = 0,
        totalPlayers = 0,
        super(
          birthday: birthday,
          id: id,
          phoneNumber: phoneNumber,
          photo64: '',
          userFirstName: userFirstName,
          userLastName: userLastName,
        );
}
