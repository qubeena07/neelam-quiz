import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/resources/app_colors.dart';
import 'package:quiz_app/utils/route_utils.dart';

import '../widgets/customize_button.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.kBgColor,
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///SizedBox(height: ,)
              Container(
                height: 150.h,
                width: 190.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/app_logo.png"))),
              ),
              Text(
                "Welcome to the",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w400,
                  //color: Colors.blackz
                ),
              ),
              Text(
                "QUIZ APP",
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w400,
                  //color: Colors.blackz
                ),
              ),
              SizedBox(
                height: 90.h,
              ),
              CustomizeButton(
                  text: "LOGIN",
                  onPress: () {
                    navigationRoute(context, route: "loginScreen");
                  }),
              SizedBox(
                height: 30.h,
              ),
              CustomizeButton(
                  text: "REGISTER",
                  onPress: () {
                    navigationRoute(context, route: "registerScreen");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
