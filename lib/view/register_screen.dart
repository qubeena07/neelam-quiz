import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/utils/route_utils.dart';
import 'package:quiz_app/view_model/auth_view_model.dart';
import 'package:quiz_app/widgets/customize_button.dart';

import '../resources/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  bool _showPassword = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
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
                "REGISTER",
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
                height: 300.h,
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
                child: Form(
                  key: formKey,
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
                          validator: (email) =>
                              email != null && EmailValidator.validate(email)
                                  ? null
                                  : "Enter a valid email",
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
                            prefixIcon: Icon(Icons.email, color: Colors.black),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
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
                              "Username",
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
                      SizedBox(
                        width: 250.w,
                        child: TextFormField(
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 8
                                  ? "Enter minimum 8 characters"
                                  : null,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              fillColor:
                                  const Color.fromARGB(160, 206, 206, 206),
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
                          text: "Register",
                          onPress: () async {
                            Map data = {
                              "email": emailController.text.toString(),
                              "username": usernameController.text.toString(),
                              "password": passwordController.text.toString(),
                            };
                            log(data.toString(), name: 'register body');
                            await authViewModel.registerApi(data, context);
                          })
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              RichText(
                text: TextSpan(
                  text: "Already have an account ?",
                  style:
                      TextStyle(fontSize: 16.sp, color: AppColors.kTextColor),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            navigationRoute(context, route: "loginScreen");
                          },
                        text: 'Login Here',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: AppColors.kPrimaryColor)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
