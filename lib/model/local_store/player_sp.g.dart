// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_sp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerSP _$PlayerSPFromJson(Map<String, dynamic> json) => PlayerSP(
      userNick: json['userNick'] as String?,
      totalGames: json['totalGames'] as int? ?? 0,
      rate: json['rate'] as int? ?? 2000,
      id: json['id'] as String,
      userLastName: json['userLastName'] as String,
      userFirstName: json['userFirstName'] as String,
      birthday: json['birthday'] as String,
      phoneNumber: json['phoneNumber'] as String,
      photo64: json['photo64'] as String,
    );

Map<String, dynamic> _$PlayerSPToJson(PlayerSP instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'userLastName': instance.userLastName,
    'userFirstName': instance.userFirstName,
    'birthday': instance.birthday,
    'phoneNumber': instance.phoneNumber,
    'photo64': instance.photo64,
    'totalGames': instance.totalGames,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userNick', instance.userNick);
  val['rate'] = instance.rate;
  return val;
}
