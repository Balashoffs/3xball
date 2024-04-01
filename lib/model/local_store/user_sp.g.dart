// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_sp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSP _$UserSPFromJson(Map<String, dynamic> json) => UserSP(
      id: json['id'] as String,
      userLastName: json['userLastName'] as String,
      userFirstName: json['userFirstName'] as String,
      birthday: json['birthday'] as String,
      phoneNumber: json['phoneNumber'] as String,
      photo64: json['photo64'] as String? ?? '',
      photoLink: json['photoLink'] as String? ?? '',
    );

Map<String, dynamic> _$UserSPToJson(UserSP instance) => <String, dynamic>{
      'id': instance.id,
      'userLastName': instance.userLastName,
      'userFirstName': instance.userFirstName,
      'birthday': instance.birthday,
      'phoneNumber': instance.phoneNumber,
      'photo64': instance.photo64,
      'photoLink': instance.photoLink,
    };
