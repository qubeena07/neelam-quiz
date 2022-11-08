import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/model/score_model.dart';
import 'package:quiz_app/response/api_response.dart';

import '../controller/api_services.dart';
import '../utils/route_utils.dart';

class ScoreViewModel extends ChangeNotifier {
  final _apiServices = ApiService();
  ApiResponse<ScoreModel> scoreList = ApiResponse.loading();
  setScoreList(ApiResponse<ScoreModel> response) {
    scoreList = response;
    notifyListeners();
  }

  Future<void> scoreApi(Map data, BuildContext context) async {
    setScoreList(ApiResponse.loading());
    // final sp = await SharedPreferences.getInstance();
    // final tokenValue = sp.getString("accessToken").toString();
    await _apiServices.postScoreApi(data).then((value) {
      setScoreList(ApiResponse.completed(value));
      log(data.toString(), name: "data value in score Api");

      Fluttertoast.showToast(msg: "Score Saved");
      navigationRoute(context, route: "scoreScreen");
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
