import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';

import '../../base/di/locator.dart';
import '../../services/network/api_store.dart';

class HomeProvider extends ChangeNotifier {
  List<VehicleModel> topVehicle = [];
  final _apiStore = locator<APIStore>();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Future<void> _fetchtopVehicle() async {
    try {
      topVehicle.clear();
      isLoading = true;
      final response = await _apiStore.vehicle_auth.fetchVehicle();
      topVehicle.addAll(response);
      //if users < 2
      notifyListeners();
    } on DioError catch (error) {
      print('DioError: '+error.message);
    } catch (error) {
      print('Error: ${error}');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  HomeProvider () {
  _fetchtopVehicle();
  }

}