import 'package:json_annotation/json_annotation.dart';

part 'rental_model.g.dart';

@JsonSerializable()
class RentalModel {
  @JsonKey(name: 'idrental')
  int? idRental;

  @JsonKey(name: 'id_user')
  int? idUser;

  @JsonKey(name: 'name')
  String? nameCus;

  @JsonKey(name: 'name_vehicle')
  String? nameBike;

  @JsonKey(name: 'id_vehicle')
  int? idVehicle;

  @JsonKey(name: 'numb_regist')
  String? numbRegister;

  @JsonKey(name: 'rentdate')
  String? rentDate;

  @JsonKey(name: 'returndate')
  String? returnDate;

  @JsonKey(name: 'total')
  double? total;

  @JsonKey(name: 'mobile')
  String? phoneCus;

  @JsonKey(name: 'avatar')
  String? avatarCus;


  RentalModel();

  factory RentalModel.fromJson(Map<String, dynamic> json) =>
      _$RentalModelFromJson(json);

  Map<String, dynamic> toJson() => _$RentalModelToJson(this);
}
