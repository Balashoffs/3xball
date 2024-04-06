import 'package:json_annotation/json_annotation.dart';

part 'user_sp.g.dart';

@JsonSerializable()
class UserSP {
  @JsonKey(includeIfNull: false)
  final String id;
  @JsonKey(includeIfNull: false)
  final String userLastName;
  @JsonKey(includeIfNull: false)
  final String userFirstName;
  @JsonKey(includeIfNull: false)
  final String birthday;
  @JsonKey(includeIfNull: false)
  final String phoneNumber;
  @JsonKey(includeIfNull: false)
  final String photo64;

  UserSP({
    required this.id,
    required this.userLastName,
    required this.userFirstName,
    required this.birthday,
    required this.phoneNumber,
    this.photo64 = '',
  });

  factory UserSP.fromJson(Map<String, dynamic> json) => _$UserSPFromJson(json);

  Map<String, dynamic> toJson() => _$UserSPToJson(this);

  UserSP.empty()
      : id = '',
        userFirstName = '',
        userLastName = '',
        birthday = '',
        phoneNumber = '',
        photo64 = '';
}
