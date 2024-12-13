import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_bike/scr/base/di/locator.dart';
import 'package:rent_bike/scr/models/user_model.dart';
import 'package:rent_bike/scr/services/network/api_store.dart';
import 'package:rent_bike/scr/services/network/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:rent_bike/scr/utils/constants.dart';

import '../../../main.dart';

class CreateCustomerProvider extends ChangeNotifier{
  final _apiStore = locator<APIStore>();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;


  final name = TextEditingController();
  final birthday = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final cmnd = TextEditingController();

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
        'mobile': phone.text,
        'email' : email.text,
        'password': '123123',
        'birthday' : birthday.text,
        'gender' : 'Nam',
        'address' : address.text,
        'national' : 'VN',
        'cmnd' : cmnd.text,
        'avatar' : 'no_image.png'
      };
      final _ = await _apiStore.auth.createUser(data);
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

  // FutureOr<void> onSubmit() async {
  //   if (formKey.currentState == null) return;
  //   if (!formKey.currentState!.validate()) return;
  //
  //   isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //
  //
  //
  //
  //
  //     isLoading = false;
  //     notifyListeners();
  //     onCreateSuccess?.call();
  //   } on DioError catch (error) {
  //     isLoading = false;
  //     notifyListeners();
  //
  //     ScaffoldMessenger.of(MyApp.context).showSnackBar(SnackBar(
  //       // content: Text(error.message ?? ''),
  //       content: Text(error.message),
  //       duration: const Duration(milliseconds: 600),
  //     ));
  //   } catch (error) {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

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
    request.fields['mobile'] = phone.text;
    request.fields['email'] = email.text;
    request.fields['password']= '123123';
    request.fields['birthday'] = birthday.text;
    request.fields['gender'] = 'Nam';
    request.fields['address'] = address.text;
    request.fields['national'] = 'VN';
    request.fields['cmnd'] = cmnd.text;
    var res = await request.send();
    if (res.statusCode == 200) {
      print('Uploaded!');
    }
    return res.reasonPhrase;
  }


}