import 'package:json_annotation/json_annotation.dart';

part 'club_sp.g.dart';

@JsonSerializable()
class ClubSP {
  @JsonKey(includeIfNull: false)
  final String clubName;
  @JsonKey(includeIfNull: false)
  final String cityName;
  @JsonKey(includeIfNull: false)
  final String countryName;
  @JsonKey(includeIfNull: false)
  final String clubPhoto;

  ClubSP({
    required this.clubName,
    required this.cityName,
    required this.countryName,
    required this.clubPhoto,
  });

  factory ClubSP.fromJson(Map<String, dynamic> json) => _$ClubSPFromJson(json);

  Map<String, dynamic> toJson() => _$ClubSPToJson(this);

  ClubSP.empty()
      : clubName = '',
        cityName = '',
        clubPhoto = '',
        countryName = '';
}
