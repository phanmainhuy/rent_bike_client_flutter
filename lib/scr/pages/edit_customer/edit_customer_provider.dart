import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/base/di/locator.dart';
import 'package:rent_bike/scr/models/user_model.dart';
import 'package:rent_bike/scr/services/network/api_store.dart';
import 'package:rent_bike/scr/utils/format.dart';

import '../../../main.dart';

class EditCustomerProvider extends ChangeNotifier {
  UserModel? userModel;
  final _apiStore = locator<APIStore>();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? onEditSuccess;
  // int? idUser;
  bool isLoading = true;

  // final
  final nameCtr = TextEditingController();
  final birthdayCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final cmndCtr = TextEditingController();

  List<UserModel> user = [];
  Format? format;

  Future<void> _fetchUser(int id) async {
    try {
      user.clear();
      final response = await _apiStore.auth.getUser(id);
      nameCtr.text = response[0].name!;
      phoneCtr.text = response[0].mobile!;
      cmndCtr.text = response[0].cmnd!;
      addressCtr.text = response[0].address!;
      emailCtr.text = response[0].email!;
      // String? birthday = format!.StringBirthday();
      DateTime birthday = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(response[0].birthday!);
      var inputDate = DateTime.parse(birthday.toString());
      // var outputFormat = DateFormat('dd/MM/yyyy');
      var outputFormat = DateFormat('yyyy-MM-dd');
      var outputDate = outputFormat.format(inputDate);
      print(outputDate);
      birthdayCtr.text = outputDate;

      // birthdayCtr.text = birthday!;
      // lstsearch.addAll(response);
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
    // notifyListeners();
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

      final _ = await _apiStore.auth.updateUser(iduser, data);

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

  EditCustomerProvider(int? idUser) {
    _fetchUser(idUser!);
  }
}
