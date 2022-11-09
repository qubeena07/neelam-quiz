import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/controller/api_services.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/utils/route_utils.dart';

class AuthViewModel extends ChangeNotifier {
  final _apiService = ApiService();

  Future<void> registerApi(Map data, BuildContext context) async {
    await _apiService.postRegisterApi(data).then((value) {
      Fluttertoast.showToast(msg: "Registration Sucessfully");
      navigationRoute(context, route: "loginScreen");
      if (kDebugMode) {
        log("value----${value.toString()}");
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Fluttertoast.showToast(msg: error.toString());
      }
    });
  }

  Future<void> loginApi(Map data, BuildContext context) async {
    // final sp = await SharedPreferences.getInstance();
    await _apiService.postLoginApi(data).then((value) {
      // final userPreference = Provider.of<UserViewModel>(context, listen: false);
      // userPreference.saveUser(value['access']);
      log(value.toString(), name: "log value");
      // log(value['access'], name: "access token value in login api");
      // sp.setString("tokenValue", value['access'].toString());
      UserModel(access: value['access'].toString());

      Fluttertoast.showToast(msg: "Login Sucessfully");
      navigationRoute(context, route: "bottomNavigationWidget");
      if (kDebugMode) {
        log("value----${value.toString()}");
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Fluttertoast.showToast(msg: error.toString());
        log(error.toString(), name: "error here");
      }
    });
  }
}
