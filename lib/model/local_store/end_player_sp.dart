import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'end_player_sp.g.dart';

@JsonSerializable()
class EndPlayerSP {
  @JsonKey(includeIfNull: false)
  final String id;
  @JsonKey(includeIfNull: false)
  final String userFirstName;
  @JsonKey(includeIfNull: false)
  final String userLastName;
  @JsonKey(includeIfNull: false)
  final int rate;
  @JsonKey(includeIfNull: false)
  final int totalGames;
  @JsonKey(includeIfNull: false)
  final String userAvatarBase64;
  @JsonKey(includeIfNull: false)
  final int delta;
  @JsonKey(includeIfNull: false)
  final int score;

  const EndPlayerSP({
    required this.id,
    required this.userFirstName,
    required this.userLastName,
    required this.rate,
    required this.totalGames,
    required this.delta,
    required this.score,
    required this.userAvatarBase64,
  });



  factory EndPlayerSP.fromJson(Map<String, dynamic> json) =>
      _$EndPlayerSPFromJson(json);

  Map<String, dynamic> toJson() => _$EndPlayerSPToJson(this);
}
