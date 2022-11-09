import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:quiz_app/controller/api_services.dart';
import 'package:quiz_app/model/api_model.dart';

import '../response/api_response.dart';

class ApiViewModel with ChangeNotifier {
  final _apiServices = ApiService();
  List<int> viewAnswer = [];
  List<int> randomAnswer = List<int>.generate(10, (index) => index + 1);
  final random = math.Random();

  ApiResponse<ApiModel>? responseList;

  Future<void> getApiService() async {
    questionAnswers(ApiResponse.loading());
    _apiServices.getQuestionAnswer().then((value) {
      questionAnswers(ApiResponse.completed(value));
      addSolution();
    }).onError((error, stackTrace) {
      questionAnswers(ApiResponse.error(error.toString()));
    });
  }

  questionAnswers(ApiResponse<ApiModel> response) {
    responseList = response;
    notifyListeners();
  }

  void addSolution() {
    viewAnswer.clear();
    viewAnswer.add(responseList!.data?.solution ?? 0);

    while (viewAnswer.length != 4) {
      var randomValue = random.nextInt(randomAnswer.length);
      if (!viewAnswer.contains(randomValue)) {
        viewAnswer.add(randomValue);
      }
    }
    viewAnswer.shuffle();
  }
}
