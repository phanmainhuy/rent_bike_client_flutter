
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_bike/scr/base/di/locator.dart';
import 'package:rent_bike/scr/models/rental_model.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';
import 'package:rent_bike/scr/services/network/api_store.dart';

class VehicleFeeListProvider extends ChangeNotifier{

  final _apiStore = locator<APIStore>();
  List<RentalModel> rentals = [];
  List<RentalModel> listSearch = [];
  final formKey = GlobalKey<FormState>();
  List<VehicleModel> vehicle = [];
  bool isLoadMore = false;
  bool isLoading = false;
  // String ?search;
  final searchCtr = TextEditingController();

  Future<void> fetchRental() async {
    // isLoading = true;
    listSearch.clear();
      try {
        final response = await _apiStore.rental.fetchRentals();
        listSearch.addAll(response);
        notifyListeners();
      } on DioError catch (error) {
        print(error.message);
      } catch (error) {
        print(error);
      }
  }

  Future<void> searchRental() async {
    // isLoading = true;
    listSearch.clear();
    await Future.delayed(const Duration(seconds: 1));
    if (searchCtr.text.isEmpty) {
      final response = await _apiStore.rental.fetchRentals();
      listSearch.addAll(response);
      notifyListeners();
      return;
    }
    else {
      try {
        final response = await _apiStore.rental.searchRentals(searchCtr.text);
        listSearch.addAll(response);
        notifyListeners();
      } on DioError catch (error) {
        print(error.message);
      } catch (error) {
        print(error);
      }
    }
  }
  Future<void> refesh() async {
    // isLoading = true;
    searchCtr.text = '';
    listSearch.clear();
    try {
      final response = await _apiStore.rental.fetchRentals();
      listSearch.addAll(response);
      notifyListeners();
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteRental(int id) async {
    try{
        final _ = await _apiStore.rental.deleteRental(id);
        notifyListeners();
    } on DioError catch (error){
      print(error.message);
    }
    catch (error){
      print(error);
    }
  }

  Future<void> returnVehicleRental (int id, String numbRegist) async {
    try {
      setStatusEmpty(numbRegist);
      final _ = await _apiStore.rental.returnVehicle(id);
      notifyListeners();
    }on DioError catch (error){
      print(error.message);
    }
    catch (err){
      print(err);
    }
  }

  // Future<VehicleModel> fetchVehicleByNumbRegist (String numb) async {
  //   try {
  //     final _ = await _apiStore.vehicle_auth.getVehicleByNumbRegist(numb);
  //     notifyListeners();
  //   }on DioError catch (error){
  //     print(error.message);
  //   }
  //   catch (err){
  //     print(err);
  //   }
  // }

  Future<void> setStatusEmpty (String numb) async {
    try {
      vehicle.clear();
      final respond = await _apiStore.vehicle_auth.getVehicleByNumbRegist(numb);
      vehicle.addAll(respond);
      final _ = await _apiStore.vehicle_auth.returnVehicle(vehicle[0].id!);
      notifyListeners();
    }on DioError catch (error){
      print(error.message);
    }
    catch (err){
      print(err);
    }
  }

  VehicleFeeListProvider(){
    // fetchRental();
    searchRental();
  }

}