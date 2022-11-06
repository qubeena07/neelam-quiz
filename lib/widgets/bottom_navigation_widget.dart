import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../view/home_screen.dart';
import '../view/score_screen.dart';
import '../view/user_profile.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int currentIndex = 0;
  final screens = [
    const ScoreScreen(),
    const HomeScreen(),
    const UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() => currentIndex = index);
          },
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.kPrimaryColor,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.scoreboard), label: "Score"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
