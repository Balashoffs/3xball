import 'package:json_annotation/json_annotation.dart';
import 'package:three_x_ball/model/local_store/user_sp.dart';

part 'player_sp.g.dart';

@JsonSerializable()
class PlayerSP extends UserSP {
  //Total games were played by player
  @JsonKey(includeIfNull: false, defaultValue: 0)
  final int totalGames;
  @JsonKey(includeIfNull: false)
  final String? userNick;

  //Player rating
  @JsonKey(includeIfNull: false, defaultValue: 2000)
  final int rate;

  PlayerSP({
    this.userNick,
    required this.totalGames,
    required this.rate,
    required String id,
    required String userLastName,
    required String userFirstName,
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

  factory PlayerSP.fromJson(Map<String, dynamic> json) =>
      _$PlayerSPFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerSPToJson(this);
}
