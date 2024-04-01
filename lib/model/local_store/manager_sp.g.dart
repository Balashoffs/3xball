// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_sp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagerSP _$ManagerSPFromJson(Map<String, dynamic> json) => ManagerSP(
      rate: json['rate'] as int,
      totalGames: json['totalGames'] as int,
      totalPlayers: json['totalPlayers'] as int,
      id: json['id'] as String,
      userFirstName: json['userFirstName'] as String,
      userLastName: json['userLastName'] as String,
      birthday: json['birthday'] as String,
      phoneNumber: json['phoneNumber'] as String,
      photo64: json['photo64'] as String,
    );

Map<String, dynamic> _$ManagerSPToJson(ManagerSP instance) => <String, dynamic>{
      'id': instance.id,
      'userLastName': instance.userLastName,
      'userFirstName': instance.userFirstName,
      'birthday': instance.birthday,
      'phoneNumber': instance.phoneNumber,
      'photo64': instance.photo64,
      'rate': instance.rate,
      'totalGames': instance.totalGames,
      'totalPlayers': instance.totalPlayers,
    };
