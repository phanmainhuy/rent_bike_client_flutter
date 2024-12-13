import 'package:dio/dio.dart';
import 'package:rent_bike/scr/models/rental_model.dart';
import 'package:retrofit/retrofit.dart' as retrofit;
import 'package:retrofit/retrofit.dart';
part 'rental_service.g.dart';


@RestApi()
abstract class RentalService{
  factory RentalService(Dio dio, {String baseUrl}) = _RentalService;
  @GET('/rentals')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<RentalModel>> fetchRentals();

  @GET('/rentals/search/{search}')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<RentalModel>> searchRentals(@Path('search') String search);

  @POST('/rentals/')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<RentalModel> createRental(@Body() Map<String, dynamic> rental);

  @PATCH('/rentals/delete/{id}')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<RentalModel>> deleteRental(@Path('id') int id);

  @PATCH('/rentals/return/{id}')
  @retrofit.Headers(
      {'Accept': 'application/json', 'Access-Control_Allow_Origin': '*'})
  Future<List<RentalModel>> returnVehicle(@Path('id') int id);

}