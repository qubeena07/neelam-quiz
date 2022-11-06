import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final demoScore = [10, 20, 12, 21, 3, 21];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
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
                  children: [
                    Text(
                      "Your Score History",
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
