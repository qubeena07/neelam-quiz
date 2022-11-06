import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_app/widgets/customize_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _oldPassword = true;
  bool _newPassword = true;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    oldPasswordController.dispose();
    newPasswordController.dispose();
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
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Change your password",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: 300.w,
                child: TextFormField(
                  controller: oldPasswordController,
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
                        "Old Password",
                        style: TextStyle(color: Colors.black),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _oldPassword = !_oldPassword;
                          });
                        },
                        child: Icon(
                            _oldPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black),
                      )),
                  obscureText: !!_oldPassword,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                width: 300.w,
                child: TextFormField(
                  controller: newPasswordController,
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
                        "New Password",
                        style: TextStyle(color: Colors.black),
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _newPassword = !_newPassword;
                          });
                        },
                        child: Icon(
                            _newPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black),
                      )),
                  obscureText: !!_newPassword,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              CustomizeButton(
                  text: "Change Password",
                  onPress: () {
                    Fluttertoast.showToast(msg: "Password Changed Sucessfully");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
