import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleModel {
  @JsonKey(name: 'id_vehicle')
  int? id;

  @JsonKey(name: 'name_vehicle')
  String? name;

  @JsonKey(name: 'license_plate')
  String? license_plate;

  @JsonKey(name: 'category')
  String? category;

  @JsonKey(name: 'rent_price')
  double? rent_price;

  @JsonKey(name: 'manufacture_year')
  String? manufacture_year;

  @JsonKey(name: 'numb_regist')
  String? numb_regist;

  @JsonKey(name: 'numb_manage')
  String? numb_manage;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'color')
  String? color;

  @JsonKey(name: 'price')
  double? price;

  @JsonKey(name: 'image')
  String? image;

  VehicleModel();

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}