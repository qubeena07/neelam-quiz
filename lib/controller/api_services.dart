import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiz_app/model/api_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_url.dart';
import 'package:http/http.dart' as http;

class ApiService with ChangeNotifier {
  Future<ApiModel> getQuestionAnswer() async {
    try {
      final response = await http
          .get(Uri.parse(AppUrl.questionUrl))
          .timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        // log(jsonResponse.toString(), name: "jsonRespinse");
        return ApiModel.fromJson(jsonResponse);
      } else {
        throw Exception("Error with Api");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }

  Future<dynamic> postRegisterApi(Map data) async {
    try {
      final response = await http
          .post(Uri.parse(AppUrl.registerEndPoint),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              },
              body: json.encode(data))
          .timeout(const Duration(seconds: 600));
      log(response.statusCode.toString(), name: 'hello');
      final registerData = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString("username", registerData["username"]);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return registerData;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> postLoginApi(Map data) async {
    try {
      final response = await http
          .post(Uri.parse(AppUrl.loginEndPoint),
              headers: {
                'Content-type': 'application/json',
                'Accept': 'application/json',
              },
              body: json.encode(data))
          .timeout(const Duration(seconds: 600));
      final responseData = jsonDecode(response.body.toString());
      log(response.body.toString(), name: "respose body value");
      final sp = await SharedPreferences.getInstance();
      sp.setString("accessToken", responseData['access']);

      log(sp.getString("accessToken").toString(), name: "getString token");

      // log(responseData.toString(), name: "respose data ");

      if (response.statusCode == 200) {
        return responseData;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future postScoreApi(Map data) async {
    final sp = await SharedPreferences.getInstance();
    final tokenValue = sp.getString("accessToken").toString();
    try {
      final response = await http
          .post(
            Uri.parse(AppUrl.scoreEndPoint),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'Authorization': tokenValue
            },
            body: json.encode(data),
          )
          .timeout(const Duration(seconds: 600));
      final responseData = jsonDecode(response.body.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseData;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
