import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'id_user')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'mobile')
  String? mobile;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'password')
  String? password;

  @JsonKey(name: 'birthday')
  String? birthday;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'cmnd')
  String? cmnd;

  @JsonKey(name: 'national')
  String? national;

  @JsonKey(name: 'avatar')
  String? avatar;

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
