// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RentalModel _$RentalModelFromJson(Map<String, dynamic> json) => RentalModel()
  ..idRental = json['idrental'] as int?
  ..idUser = json['id_user'] as int?
  ..nameCus = json['name'] as String?
  ..nameBike = json['name_vehicle'] as String?
  ..idVehicle = json['id_vehicle'] as int?
  ..numbRegister = json['numb_regist'] as String?
  ..rentDate = json['rentdate'] as String?
  ..returnDate = json['returndate'] as String?
  ..total = (json['total'] as num?)?.toDouble()
  ..phoneCus = json['mobile'] as String?
  ..avatarCus = json['avatar'] as String?;

Map<String, dynamic> _$RentalModelToJson(RentalModel instance) =>
    <String, dynamic>{
      'idrental': instance.idRental,
      'id_user': instance.idUser,
      'name': instance.nameCus,
      'name_vehicle': instance.nameBike,
      'id_vehicle': instance.idVehicle,
      'numb_regist': instance.numbRegister,
      'rentdate': instance.rentDate,
      'returndate': instance.returnDate,
      'total': instance.total,
      'mobile': instance.phoneCus,
      'avatar': instance.avatarCus,
    };
