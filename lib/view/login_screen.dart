import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../resources/app_colors.dart';
import '../utils/route_utils.dart';
import '../view_model/auth_view_model.dart';
import '../widgets/customize_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = true;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 10.h),

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
                "LOGIN",
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
                width: 320.w,
                height: 240.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(255, 193, 193, 193),
                        blurRadius: 8.0.r)
                  ],
                  color: Colors.white,
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
                        controller: usernameController,
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
                      height: 20.h,
                    ),
                    SizedBox(
                      width: 250.w,
                      child: TextFormField(
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            fillColor: const Color.fromARGB(160, 206, 206, 206),
                            filled: true,
                            border: InputBorder.none,
                            label: const Text(
                              "Password",
                              style: TextStyle(color: Colors.black),
                            ),
                            prefixIcon:
                                const Icon(Icons.lock, color: Colors.black),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                  _showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black),
                            )),
                        obscureText: !!_showPassword,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomizeButton(
                        text: "Login",
                        onPress: () async {
                          // navigationRoute(context,
                          //     route: "bottomNavigationWidget");
                          Map data = {
                            "username": usernameController.text.toString(),
                            "password": passwordController.text.toString(),
                          };
                          authViewModel.loginApi(data, context);
                          log(data.toString(),
                              name: "map data value of login screen");

                          //  BottomNavigationBar;
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                child: Text("Forgot Password ?",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        fontSize: 17.sp,
                        color: AppColors.kPrimaryColor)),
                onTap: () {
                  navigationRoute(context, route: "forgotPassword");
                },
              ),
              SizedBox(
                height: 8.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
