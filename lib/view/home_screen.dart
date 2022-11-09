import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/resources/app_colors.dart';
import 'package:quiz_app/view_model/api_view_model.dart';
import 'package:quiz_app/view_model/point_view_model.dart';
import 'package:quiz_app/view_model/score_view_model.dart';
import 'package:quiz_app/widgets/customize_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PointViewModel pointViewModel = PointViewModel();
  ScoreViewModel scoreViewModel = ScoreViewModel();
  static const maxSeconds = 10;
  int seconds = maxSeconds;
  Timer? timer;

  ApiViewModel apiViewModel = ApiViewModel();
  List<String> solutionIndex = ['a.', 'b.', 'c.', 'd.'];
  int solutionIndicator = -1;

  showQuestion() async {
    await apiViewModel.getApiService();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (seconds == 0) {
        timer.cancel();
        final sp = await SharedPreferences.getInstance();
        final senderValue = sp.getString("userId");
        log(senderValue.toString(), name: "senderValue ");

        seconds = maxSeconds;
        Map data = {
          "score": 9999,
          //pointViewModel.score.toInt(),
          //"${pointViewModel.score}",
          "timesPlayed": "70",
          "sender": 1,
        };
        // ignore: use_build_context_synchronously
        scoreViewModel.scoreApi(data, context);
        pointViewModel.resetScore();
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  void initState() {
    showQuestion();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (seconds == 0)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(height: 20),
                    Text(
                      'Calculating Score',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomizeButton(
                        text: "Play",
                        onPress: () async {
                          await apiViewModel.getApiService();
                          startTimer();
                        }),
                    Container(
                      child: (seconds == 0) ? null : linearIndicator(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          //color: Color.fromARGB(255, 236, 236, 236)
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Your Score :${pointViewModel.score} ",
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w700),
                            ),
                            ChangeNotifierProvider<ApiViewModel>(
                              create: (BuildContext context) => apiViewModel,
                              child: Consumer<ApiViewModel>(
                                  builder: ((context, value, _) {
                                log(value.responseList!.data.toString(),
                                    name: "response list");
                                switch (value.responseList?.status) {
                                  case Status.loading:
                                    return const CircularProgressIndicator(); //

                                  case Status.error:
                                    return Text(value.responseList?.message
                                            .toString() ??
                                        '');
                                  case Status.completed:
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 250.h,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(value
                                                          .responseList
                                                          ?.data!
                                                          .question
                                                          .toString() ??
                                                      ""))),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        GridView.builder(
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 3,
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 15,
                                                    mainAxisSpacing: 30),
                                            itemCount: value.viewAnswer.length,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: ListTile(
                                                  leading: Text(
                                                    solutionIndex[value
                                                        .viewAnswer
                                                        .indexOf(
                                                            value.viewAnswer[
                                                                index])],
                                                    style: TextStyle(
                                                        // color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 15.sp),
                                                  ),
                                                  onTap: () async {
                                                    setState(() {
                                                      solutionIndicator = value
                                                          .viewAnswer
                                                          .indexOf(
                                                              value.viewAnswer[
                                                                  index]);
                                                    });

                                                    if (value.responseList
                                                            ?.data!.solution
                                                            .toString() ==
                                                        value.viewAnswer[index]
                                                            .toString()) {
                                                      pointViewModel
                                                          .totalScore();

                                                      pointViewModel
                                                          .questionNum();

                                                      Future.delayed(
                                                        const Duration(
                                                            seconds: 1),
                                                        () async {
                                                          await apiViewModel
                                                              .getApiService();

                                                          setState(() {
                                                            solutionIndicator =
                                                                -1;
                                                          });
                                                        },
                                                      );
                                                    } else {
                                                      Future.delayed(
                                                        const Duration(
                                                            seconds: 1),
                                                        () async {
                                                          log("else statement here");
                                                          await apiViewModel
                                                              .getApiService();

                                                          setState(() {
                                                            solutionIndicator =
                                                                -1;
                                                          });
                                                        },
                                                      );

                                                      pointViewModel
                                                          .questionNum();
                                                    }
                                                  },
                                                  title: Text(
                                                    value.viewAnswer[index]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20.sp),
                                                  ),
                                                ),
                                              );
                                            }),
                                        // if (false)
                                        //   Wrap(
                                        //       children: value.viewAnswer
                                        //           .map((e) => const Padding(
                                        //                 padding: EdgeInsets.symmetric(
                                        //                     vertical: 10.0),
                                        //                 // child: Container(
                                        //                 //   decoration: BoxDecoration(
                                        //                 //       color:
                                        //                 //           AppColors.kPrimaryColor,
                                        //                 //       borderRadius:
                                        //                 //           BorderRadius.circular(
                                        //                 //               20)),

                                        //                 // color: Colors.yellow,

                                        //                 // child: ListTile(
                                        //                 //   // trailing: Visibility(
                                        //                 //   //     visible:
                                        //                 //   //         (solutionIndicator ==
                                        //                 //   //             value.viewAnswer
                                        //                 //   //                 .indexOf(e)),
                                        //                 //   //     child: (value
                                        //                 //   //                 .responseList
                                        //                 //   //                 ?.data!
                                        //                 //   //                 .solution ==
                                        //                 //   //             e)
                                        //                 //   //         ? const Icon(
                                        //                 //   //             Icons.check)
                                        //                 //   //         : const Icon(
                                        //                 //   //             Icons.close)),
                                        //                 //   leading: Text(
                                        //                 //     solutionIndex[value.viewAnswer
                                        //                 //         .indexOf(e)],
                                        //                 //     style: TextStyle(
                                        //                 //         // color: Colors.white,
                                        //                 //         fontWeight: FontWeight.w400,
                                        //                 //         fontSize: 15.sp),
                                        //                 //   ),
                                        //                 //   onTap: () async {
                                        //                 //     setState(() {
                                        //                 //       solutionIndicator = value
                                        //                 //           .viewAnswer
                                        //                 //           .indexOf(e);
                                        //                 //     });

                                        //                 //     if (value.responseList?.data!
                                        //                 //             .solution ==
                                        //                 //         e) {
                                        //                 //       pointViewModel.totalScore();

                                        //                 //       pointViewModel.questionNum();
                                        //                 //       Future.delayed(
                                        //                 //         const Duration(seconds: 1),
                                        //                 //         () async {
                                        //                 //           await apiViewModel
                                        //                 //               .getApiService();

                                        //                 //           setState(() {
                                        //                 //             solutionIndicator = -1;
                                        //                 //           });
                                        //                 //         },
                                        //                 //       );
                                        //                 //     } else {
                                        //                 //       Future.delayed(
                                        //                 //         const Duration(seconds: 1),
                                        //                 //         () async {
                                        //                 //           await apiViewModel
                                        //                 //               .getApiService();

                                        //                 //           setState(() {
                                        //                 //             solutionIndicator = -1;
                                        //                 //           });
                                        //                 //         },
                                        //                 //       );

                                        //                 //       pointViewModel.questionNum();
                                        //                 //     }
                                        //                 //   },
                                        //                 //   title: Text(
                                        //                 //     e.toString(),
                                        //                 //     style: TextStyle(
                                        //                 //         fontWeight: FontWeight.w400,
                                        //                 //         fontSize: 20.sp),
                                        //                 //   ),
                                        //                 // ),
                                        //                 // ),
                                        //               ))
                                        //           .toList())
                                      ],
                                    );
                                  default:
                                    Container();
                                }
                                return Container();
                              })),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget linearIndicator() {
    return SizedBox(
      height: 20.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          LinearProgressIndicator(
            color: Colors.green,
            value: seconds / maxSeconds,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [timerDisplay()],
          )
        ],
      ),
    );
  }

  Widget timerDisplay() {
    return FittedBox(
      child: Text(
        seconds.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.sp,
        ),
      ),
    );
  }
}
