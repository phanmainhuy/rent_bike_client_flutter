import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rent_bike/scr/base/di/locator.dart';
import 'package:rent_bike/scr/models/user_model.dart';
import 'package:rent_bike/scr/services/network/api_store.dart';

class UserProvider extends ChangeNotifier {
  bool checkoutColor = false;

  // int get countCart => users.length;
  int get countCart => 0;

  final _apiStore = locator<APIStore>();
  List<UserModel> users = [];
  List<UserModel> lstsearch = [];

  final formKey = GlobalKey<FormState>();

  bool isLoadMore = false;
  bool isLoading = false;

  // String ?search;
  final searchCtr = TextEditingController();

  //edit
  final nameCtr = TextEditingController();
  final birthdayCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final cmndCtr = TextEditingController();

  Future<void> _fetchUsers() async {
    try {
      users.clear();
      isLoading = true;
      // await Future.delayed(const Duration(seconds: 3));
      final response = await _apiStore.auth.fetchUser();
      // await Future.delayed(const Duration(seconds: 3));
      users.addAll(response);
      //if users < 2
      isLoadMore = users.length < 2;
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

  void onLoadMore() {
    if (!isLoadMore) return;
    if (isLoading) return;

    _fetchUsers();
  }

  Future<void> searchUser() async {
    // isLoading = true;
    lstsearch.clear();
    await Future.delayed(const Duration(seconds: 1));
    if (searchCtr.text.isEmpty) {
      final response = await _apiStore.auth.fetchUser();
      lstsearch.addAll(response);
      notifyListeners();
    }
    else {
      try {
        final response = await _apiStore.auth.searchUser(searchCtr.text);
        lstsearch.addAll(response);
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
      users.clear();
      isLoading = true;

      // await Future.delayed(const Duration(seconds: 3));
      final response = await _apiStore.auth.fetchUser();
      users.addAll(response);
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


  void removeUser(int id) {
    // final removeItem = users.removeAt(index);
    notifyListeners();
    _apiStore.auth.deleteUser(id);
  }






  UserProvider() {

    _fetchUsers();
    searchUser();
  }
}
