// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..id = json['id_user'] as int?
  ..name = json['name'] as String?
  ..mobile = json['mobile'] as String?
  ..email = json['email'] as String?
  ..password = json['password'] as String?
  ..birthday = json['birthday'] as String?
  ..gender = json['gender'] as String?
  ..address = json['address'] as String?
  ..cmnd = json['cmnd'] as String?
  ..national = json['national'] as String?
  ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id_user': instance.id,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'password': instance.password,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'address': instance.address,
      'cmnd': instance.cmnd,
      'national': instance.national,
      'avatar': instance.avatar,
    };
