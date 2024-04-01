// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_player_sp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EndPlayerSP _$EndPlayerSPFromJson(Map<String, dynamic> json) => EndPlayerSP(
      id: json['id'] as String,
      userFirstName: json['userFirstName'] as String,
      userLastName: json['userLastName'] as String,
      rate: json['rate'] as int,
      totalGames: json['totalGames'] as int,
      delta: json['delta'] as int,
      score: json['score'] as int,
      userAvatarBase64: json['userAvatarBase64'] as String,
    );

Map<String, dynamic> _$EndPlayerSPToJson(EndPlayerSP instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userFirstName': instance.userFirstName,
      'userLastName': instance.userLastName,
      'rate': instance.rate,
      'totalGames': instance.totalGames,
      'userAvatarBase64': instance.userAvatarBase64,
      'delta': instance.delta,
      'score': instance.score,
    };
