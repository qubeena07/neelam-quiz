import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/response/api_response.dart';

import '../controller/api_services.dart';
import '../model/score_model.dart';

class AllScoreViewModel extends ChangeNotifier {
  final _apiServices = ApiService();
  ApiResponse<List<ScoreModel>> scoreApiList = ApiResponse.loading();
  getAllScoreList(ApiResponse<List<ScoreModel>> response) {
    scoreApiList = response;
    notifyListeners();
  }

  Future<void> getAllScoreApi() async {
    getAllScoreList(ApiResponse.loading());
    await _apiServices.getScoreApi().then((value) {
      print(value);
      getAllScoreList(ApiResponse.completed(value));
      // log(value.toString(), name: 'values');
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        log(error.toString(), name: "error here");
        Fluttertoast.showToast(msg: error.toString());
      }
    });
  }
}
