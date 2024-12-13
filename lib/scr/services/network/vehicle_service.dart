import 'package:dio/dio.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';

import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:retrofit/retrofit.dart';

part  'vehicle_service.g.dart';

@RestApi()
abstract class VehicleService {
  factory VehicleService(Dio dio, {String baseUrl}) = _VehicleService;

  @GET('/vehicle/')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<VehicleModel>> fetchVehicle();

  @GET('/vehicle/search/{search}')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<VehicleModel>> searchVehicle(@Path('search') String search);

  // @POST('/vehicle/create/')
  // @retrofit.Headers(
  //     {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  // Future<VehicleModel> createVehicle(@Body() Map<String, dynamic> vehicle);

  @POST('/vehicle/')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<VehicleModel> createVehicle(@Body() Map<String, dynamic> vehicle);

  @GET('/vehicle/number/{numb}')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<VehicleModel>> getVehicleByNumber(@Path('numb') String number);

  @PATCH('/vehicle/rented/{id}')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<VehicleModel>> updateRentedVehicle(@Path('id') int id);

  @PATCH('/vehicle/empty/{id}')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<VehicleModel>> returnVehicle(@Path('id') int id);

  @GET('/vehicle/getbynumbregist/{numb}')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<VehicleModel>> getVehicleByNumbRegist(@Path('numb') String number);


}