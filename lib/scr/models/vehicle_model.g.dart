// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) => VehicleModel()
  ..id = json['id_vehicle'] as int?
  ..name = json['name_vehicle'] as String?
  ..license_plate = json['license_plate'] as String?
  ..category = json['category'] as String?
  ..rent_price = (json['rent_price'] as num?)?.toDouble()
  ..manufacture_year = json['manufacture_year'] as String?
  ..numb_regist = json['numb_regist'] as String?
  ..numb_manage = json['numb_manage'] as String?
  ..status = json['status'] as String?
  ..color = json['color'] as String?
  ..price = (json['price'] as num?)?.toDouble()
  ..image = json['image'] as String?;

Map<String, dynamic> _$VehicleModelToJson(VehicleModel instance) =>
    <String, dynamic>{
      'id_vehicle': instance.id,
      'name_vehicle': instance.name,
      'license_plate': instance.license_plate,
      'category': instance.category,
      'rent_price': instance.rent_price,
      'manufacture_year': instance.manufacture_year,
      'numb_regist': instance.numb_regist,
      'numb_manage': instance.numb_manage,
      'status': instance.status,
      'color': instance.color,
      'price': instance.price,
      'image': instance.image,
    };
