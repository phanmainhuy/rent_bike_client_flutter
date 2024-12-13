import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/base/di/locator.dart';
import 'package:rent_bike/scr/models/vehicle_model.dart';
import 'package:rent_bike/scr/services/network/api_store.dart';


import '../../../../main.dart';

class EditVehicleProvider extends ChangeNotifier {
  VehicleModel? vehicleModel;
  final _apiStore = locator<APIStore>();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? onEditSuccess;

  bool isLoading = true;

  // final
  final nameCtr = TextEditingController();
  final birthdayCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final cmndCtr = TextEditingController();

  // Future<void> onUpdate() async{
  //     if (formKey.currentState == null) return;
  //     if (!formKey.currentState!.validate()) return;
  //     notifyListeners();
  //
  //
  //
  //
  // }
  Future<void> _fetchUser() async {
    try {
      // products = await _fireStore.fetchCart();
      // nameCtr.text = userModel?.name! ?? '';
      nameCtr.text = "Do Thanh Phuong";
      phoneCtr.text = "0902873146";
      cmndCtr.text = "215935846";
      addressCtr.text = "Gò Vấp";
      emailCtr.text = "thanhphuong@gmail.com";
      birthdayCtr.text = "24-06-2000";
      notifyListeners();
    } on DioError catch (error) {
      print(error.message);
    } catch (error) {
      print(error);
    }
  }

  FutureOr<void> onSubmit(int iduser) async {
    //error formkey
    // if (formKey.currentState == null) return;
    // if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> data = {
        'name': nameCtr.text,
        'mobile': phoneCtr.text,
        'email': emailCtr.text,
        'password': '123123',
        'birthday': birthdayCtr.text,
        'gender': 'Nam',
        'address': addressCtr.text,
        'national': 'VN',
        'cmnd': cmndCtr.text,
        // 'avatar' : 'user1.png'
      };

      //final _ = await _apiStore.auth.updateUser(iduser, data);

      isLoading = false;
      notifyListeners();
      onEditSuccess?.call();
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

  EditCustomerProvider() {
    _fetchUser();
  }
}