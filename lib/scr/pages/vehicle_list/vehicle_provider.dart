import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_bike/scr/base/di/locator.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';
import 'package:rent_bike/scr/services/network/api_store.dart';

class VehicleProvider extends ChangeNotifier {
  bool checkoutColor = false;

  // int get countCart => users.length;
  int get countCart => 0;

  final _apiStore = locator<APIStore>();
  List<VehicleModel> vehicle = [];
  List<VehicleModel> lstsearch_vehicle = [];
  List<VehicleModel> lstloadmore_vehicle = [];

  final formKey = GlobalKey<FormState>();

  // String ?search;
  final searchCtr = TextEditingController();

  bool isLoadMore = false;
  bool isLoading = false;

  Future<void> _fetchVehicle() async {
    try {
      vehicle.clear();
      isLoading = true;
      // await Future.delayed(const Duration(seconds: 3));
      final response = await _apiStore.vehicle_auth.fetchVehicle();
      // await Future.delayed(const Duration(seconds: 3));
      vehicle.addAll(response);
      //if users < 2
      isLoadMore = vehicle.length < 2;
      notifyListeners();
    } on DioError catch (error) {
      // if (error.response?.statusCode == 404){
      //   print('bad request 404');
      // }
      print('DioError: '+error.message);
    } catch (error) {
      print('Error: ${error}');
    } finally {
      isLoading = false;
      notifyListeners();
    }

  }

  void onLoadMore() {
    if (!isLoadMore) return;
    if (isLoading) return;

    _fetchVehicle();
  }

  Future<void> searchVehicle() async {
    final response = await _apiStore.vehicle_auth.fetchVehicle();
    lstsearch_vehicle.addAll(response);
    if (searchCtr.text.isEmpty) {
      return;
    }
    else {
      try {
        lstsearch_vehicle.clear();
        final response = await _apiStore.vehicle_auth.searchVehicle(searchCtr.text);
        lstsearch_vehicle.addAll(response);
        notifyListeners();
      } on DioError catch (error) {
        print(error.message);
      } catch (error) {
        print(error);
      }
    }
  }
  Future<void> refesh() async {
    try {
      vehicle.clear();
      isLoading = true;
      // await Future.delayed(const Duration(seconds: 3));
      final response = await _apiStore.vehicle_auth.fetchVehicle();
      // await Future.delayed(const Duration(seconds: 3));
      vehicle.addAll(response);
      //if users < 2
      isLoadMore = vehicle.length < 2;
      notifyListeners();
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  VehicleProvider() {
    _fetchVehicle();
    searchVehicle();
  }
}