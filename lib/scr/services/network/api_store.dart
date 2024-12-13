import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rent_bike/scr/services/network/vehicle_service.dart';
import 'package:rent_bike/scr/services/network/rental_service.dart';
import 'package:rent_bike/scr/utils/constants.dart';
import 'rental_service.dart';
import 'auth_service.dart';

class APIStore {
  final Dio dio = Dio();
  late AuthService auth;
  late VehicleService vehicle_auth;
  late RentalService rental;

  APIStore() {
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
          responseBody: true, requestBody: true, request: true));
    }

    try {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =((X509Certificate cert, String host, int port) => true);
        // print('respond ${HttpStatus.badRequest}');
      };
    } catch (_) {}

    auth = AuthService(dio, baseUrl: Constants.apiUrl);
    vehicle_auth = VehicleService(dio, baseUrl: Constants.apiUrl);
    rental = RentalService(dio, baseUrl: Constants.apiUrl);
  }
}
