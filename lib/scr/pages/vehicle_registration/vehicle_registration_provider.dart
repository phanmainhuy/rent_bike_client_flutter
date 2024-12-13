import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_bike/scr/base/di/locator.dart';
import 'package:rent_bike/scr/services/network/api_store.dart';
import 'package:rent_bike/scr/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';

class VehicleRegistrationProvider extends ChangeNotifier{
  final _apiStore = locator<APIStore>();
  // final _auth = locator<AuthService>;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;


  final name = TextEditingController();
  final license_plate = TextEditingController();
  final category = TextEditingController();
  final rent_price = TextEditingController();
  final manufacture_year = TextEditingController();
  final numb_regist = TextEditingController();
  final numb_manage = TextEditingController();
  final color = TextEditingController();
  final price = TextEditingController();

  VoidCallback? onCreateSuccess;

  //submit
  FutureOr<void> onSubmitNoFile() async {
    if (formKey.currentState == null) return;
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> data= {
        'name' : name.text,
        'license_plate': license_plate.text,
        'category' : category.text,
        'rent_price' : rent_price.text,
        'manufacture_year': manufacture_year.text,
        'numb_regist' : numb_regist.text,
        'numb_manage' : numb_manage.text,
        'status': 'Còn trống',
        'color' : color.text,
        'price' : price.text,
        'image' : 'no_image.png'
      };


      final _ = await _apiStore.vehicle_auth.createVehicle(data);

      isLoading = false;
      notifyListeners();
      onCreateSuccess?.call();
    } on DioError catch (error) {
      //isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(MyApp.context).showSnackBar(SnackBar(
        // content: Text(error.message ?? ''),
        content: Text(error.message),
        duration: const Duration(milliseconds: 600),
      ));
    } catch (error) {
      //isLoading = false;
      notifyListeners();
    }
  }

  FutureOr<void> onSubmit(File? file) async {
    if (formKey.currentState == null) return;
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    try {

      uploadImageHTTP(file);

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




//http ok!
  Future<String?> uploadImageHTTP(file) async {
    String url = "http://${Constants.ip}:3000/api/users/create/";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    request.fields['name'] = name.text;
    request.fields['license_plate'] = license_plate.text;
    request.fields['category'] =category.text;
    request.fields['rent_price'] = rent_price.text;
    request.fields['manufacture_year']= manufacture_year.text;
    request.fields['numb_regist'] = numb_regist.text;
    request.fields['numb_manage'] = numb_manage.text;
    request.fields['status'] = 'Còn trống';
    request.fields['color'] = color.text;
    request.fields['price'] = price.text;
    var res = await request.send();
    if (res.statusCode == 200) {
      print('Uploaded!');
    }
    return res.reasonPhrase;
  }

}