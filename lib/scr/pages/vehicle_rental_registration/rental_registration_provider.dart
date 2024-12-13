

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:rent_bike/scr/base/di/locator.dart';
import 'package:rent_bike/scr/models/user_model.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';
import 'package:rent_bike/scr/services/network/api_store.dart';
import 'package:rent_bike/scr/utils/format.dart';
import 'package:rent_bike/scr/utils/money_format.dart';

import '../../../main.dart';
import '../../common/channel_constants.dart';
import '../../common/error_codes.dart';
import '../../common/error_messages.dart';
import '../../models/platform_specifics/models/result.dart';

class RentalRegistrationProvider extends ChangeNotifier{
  final _apiStore = locator<APIStore>();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<UserModel> user = [];
  List<VehicleModel> vehicle = [];
  late MoneyFormat moneyFormat;
  double total = 0;
  double priceVehicle = 0;
  late final int dayLeft;


  VoidCallback? onCreateSuccess;
  late final DateTime? rent;

  final numbBike = TextEditingController();
  final rentDate = TextEditingController();
  final returnDate = TextEditingController();
  final rentPrice = TextEditingController();
  final daysLeft = TextEditingController();
  final nameCus = TextEditingController();
  final nameBike = TextEditingController();
  final numbCus = TextEditingController();

  //find name Bike by num bike
  Future<void> getUserByMobile() async {
    // isLoading = true;

    user.clear();

    if (numbCus.text.isEmpty) {
      return;
    }
    else {
      try {
        final response = await _apiStore.auth.getUserByMobile(numbCus.text);
        user.addAll(response);
        if (user.length <= 0){
          nameCus.text = 'Không tìm thấy người dùng';
          notifyListeners();
        }
        else
          {
            nameCus.text = user[0].name!;
            notifyListeners();
          }
      } on DioError catch (error) {
        print(error.message);
      } catch (error) {
        print(error);
      }
    }
  }
  //find price
  Future<void> getVehicleByNumber() async {
    vehicle.clear();
    if (numbBike.text.isEmpty) {
      return;
    }
    else {
      try {
        final response = await _apiStore.vehicle_auth.getVehicleByNumber(numbBike.text);
        vehicle.addAll(response);
        if (vehicle.length <= 0){
          nameBike.text = 'Không tìm thấy xe';
          rentPrice.text = 'Không tìm thấy xe';
          notifyListeners();
        }
        if (vehicle[0].status == "Đã thuê") {
          nameBike.text = 'Xe đã được cho thuê';
          rentPrice.text = 'Xe đã được cho thuê';

          notifyListeners();
          return;
        }
        if (vehicle[0].status == "Đang sửa chữa") {
          nameBike.text = 'Xe đang được sửa chữa';
          rentPrice.text = 'Xe đang được sửa chữa';
          notifyListeners();
          return;
        }
        else
        {
          nameBike.text = vehicle[0].name!;
          double a = vehicle[0].rent_price!;
          rentPrice.text = Format.moneyFormat(a)!;
          priceVehicle = a;

          notifyListeners();
        }
      } on DioError catch (error) {
        print(error.message);
      } catch (error) {
        print(error);
      }
    }
  }

  //create rental
  //submit
  FutureOr<void> onSubmitRental() async {
    if (formKey.currentState == null) return;
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    total = dayLeft * priceVehicle;

    try {
      final Map<String, dynamic> data= {
        "id_user": user[0].id,
        "id_vehicle": vehicle[0].id,
        "rentdate": rentDate.text,
        "returndate": returnDate.text,
        "total": total
      };
      final _ = await _apiStore.rental.createRental(data);
      updateRentedVehicle();
      isLoading = false;
      notifyListeners();
      onCreateSuccess?.call();
    } on DioError catch (error) {
      isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(MyApp.context).showSnackBar(SnackBar(
        // content: Text(error.message ?? ''),
        content: Text(error.message),
        duration: const Duration(milliseconds: 600),
      ));
    } catch (error) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateRentedVehicle() async {
    final _ = await _apiStore.vehicle_auth.updateRentedVehicle(vehicle[0].id ?? 0);
  }



  RentalRegistrationProvider() {
  }


}