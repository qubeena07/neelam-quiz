import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiz_app/model/api_model.dart';
import 'package:quiz_app/model/score_model.dart';
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
      log(response.statusCode.toString(), name: 'status code');
      final registerData = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString("senderId", registerData["sender"]);
      log(registerData["sender"].toString(), name: "senderId value");

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

  Future<dynamic> postScoreApi(Map data) async {
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
      final responseData = jsonDecode(response.body);

      log(responseData.toString(), name: 'data value');
      sp.setString("senderId", responseData['sender'].toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ScoreModel.fromJson(responseData);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> getScoreApi() async {
    final sp = await SharedPreferences.getInstance();
    final tokenValue = sp.getString("accessToken").toString();
    try {
      final response =
          await http.get(Uri.parse(AppUrl.allScoreEndPoint), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': tokenValue
      }).timeout(const Duration(seconds: 600));
      final List responseData = jsonDecode(response.body);
      log(responseData.toString(), name: 'all score value');
      log(response.statusCode.toString(), name: "status code");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var value = ScoreModel.fromJson(responseData);

        List<ScoreModel> scoreModelValue = [];
        for (var each in responseData) {
          scoreModelValue.add(ScoreModel.fromJson(each));
        }
        log(scoreModelValue.toString(), name: 'name');
        return scoreModelValue;
        // return ScoreModel.fromJson(responseData);
        // return (responseData as List).map((e) => ScoreModel.fromJson(e));
        // return responseData;
      }
    } catch (e) {
      log(e.toString(), name: "error");
      Exception(e.toString());
    }
  }
}
