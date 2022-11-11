import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/utils/route.dart';
import 'package:quiz_app/view/first_screen.dart';
import 'package:quiz_app/view/forgot_password.dart';
import 'package:quiz_app/view/home_screen.dart';
import 'package:quiz_app/view/login_screen.dart';
import 'package:quiz_app/view/password_screen.dart';
import 'package:quiz_app/view/register_screen.dart';
import 'package:quiz_app/view/score_screen.dart';
import 'package:quiz_app/view_model/all_score_view_model.dart';
import 'package:quiz_app/view_model/auth_view_model.dart';
import 'package:quiz_app/view_model/point_view_model.dart';
import 'package:quiz_app/view_model/user_view_model.dart';
import 'package:quiz_app/widgets/bottom_navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLogin = prefs.getBool("loggedIn") ?? false;

  runApp(MyApp(
    isLogin: isLogin,
  ));
  log(isLogin.toString(), name: "islogin value ");
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp({
    Key? key,
    required this.isLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthViewModel()),
            ChangeNotifierProvider(create: (_) => UserViewModel()),
            ChangeNotifierProvider(create: (_) => PointViewModel()),
            ChangeNotifierProvider(create: (_) => AllScoreViewModel())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Quiz App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:
                //isLogin ? const HomeScreen() :
                const FirstScreen(),
            routes: {
              loginScreen: (context) => const LoginScreen(),
              registerScreen: (context) => const RegisterScreen(),
              firstScreen: (context) => const FirstScreen(),
              homeScreen: (context) => const HomeScreen(),
              bottomNavigationWidget: (context) =>
                  const BottomNavigationWidget(),
              passwordScreen: (context) => const PasswordScreen(),
              forgotPassword: (context) => const ForgotPassword(),
              scoreScreen: (context) => const ScoreScreen()
            },
          ),
        );
      },
    );
  }
}
