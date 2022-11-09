import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/utils/route_utils.dart';

import '../widgets/customize_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: Column(
              children: [
                // SizedBox(height: .h),
                Container(
                  height: 150.h,
                  width: 190.w,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/app_logo.png"))),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  width: 300.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 197, 197, 197),
                          blurRadius: 8.0.r)
                    ],
                    color: Colors.white,
                    // color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 250.w,
                        child: TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color.fromARGB(160, 206, 206, 206),
                            filled: true,
                            label: Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.black),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      CustomizeButton(
                          text: "Reset",
                          onPress: () {
                            Fluttertoast.showToast(
                                msg: "Check your email for password reset");
                            navigationRoute(context, route: "");
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
