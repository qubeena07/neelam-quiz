import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/view_model/all_score_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../response/status.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final demoScore = [10, 20, 12, 21, 3, 21];
  AllScoreViewModel allScoreViewModel = AllScoreViewModel();
  var senderId = "";

  @override
  void initState() {
    super.initState();
    allScoreViewModel.getAllScoreApi();
    getSenderId();
  }

  void getSenderId() async {
    final sp = await SharedPreferences.getInstance();
    senderId = sp.getString("senderId") ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log(senderId.toString(), name: "senderid value in screen");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
            height: double.infinity,
            width: 160.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: const Color.fromARGB(255, 193, 193, 193),
                    blurRadius: 8.0.r)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Your Score History",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Flexible(
                      child: ChangeNotifierProvider<AllScoreViewModel>(
                        create: (BuildContext context) => allScoreViewModel,
                        child: Consumer<AllScoreViewModel>(
                            builder: (context, value, _) {
                          log(value.scoreApiList.data![0].score.toString(),
                              name: "length of score api service");
                          log(value.scoreApiList.status.toString(),
                              name: "scoreapilist status");
                          switch (value.scoreApiList.status) {
                            case Status.loading:
                              return const Center(
                                  child: CircularProgressIndicator());

                            case Status.error:
                              return Center(
                                  child: Text(
                                      value.scoreApiList.message.toString()));

                            case Status.completed:
                              return ListView.builder(
                                //physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.scoreApiList.data!.length,
                                itemBuilder: (context, index) {
                                  // ignore: unrelated_type_equality_checks
                                  if (value.scoreApiList.data![index].sender
                                          .toString() ==
                                      senderId.toString()) {
                                    return ListTile(
                                      title: Text(
                                        value.scoreApiList.data![index].score
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              );
                            default:
                              return Container();
                          }
                        }),
                      ),
                    )
                  ]),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            height: double.infinity,
            width: 170.w,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: const Color.fromARGB(255, 193, 193, 193),
                    blurRadius: 8.0.r)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "HIGHEST SCORE",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    const ListTile(
                      title: Text("10"),
                    ),
                    const ListTile(
                      title: Text("9"),
                    ),
                    const ListTile(
                      title: Text("8"),
                    ),
                    const ListTile(
                      title: Text("7"),
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
