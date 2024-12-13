import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_bike/scr/models/user_model.dart';
import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @GET('/users')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<UserModel>> fetchUser();

  @GET('/users/search/{search}')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<UserModel>> searchUser(@Path('search') String search);

  // @DELETE("/users/{id}")
  // @retrofit.Headers(
  //     {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  // Future<void> deleteUser(@Path('id') int id);

  @PATCH("/users/delete/{id}")
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<void> deleteUser(@Path('id') int id);

  @POST('/users/')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<UserModel> createUser(@Body() Map<String, dynamic> user);

  @PATCH("/users/{id}")
  Future<UserModel> updateUser(@Path('id') int id, @Body() Map<String, dynamic> user);

  @GET('/users/{id}')
  Future<List<UserModel>> getUser(@Path('id') int id);

  @GET('/users/mobile/{mobile}')
  Future<List<UserModel>> getUserByMobile(@Path('mobile') String mobile);

}
