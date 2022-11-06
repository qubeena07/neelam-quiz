import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/utils/route_utils.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 200.h,
              width: double.infinity,
              color: Colors.red,
              child: const Center(
                child: Text("user profile or name here"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                replacedNavigation(context, route: "loginScreen");
              },
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text("Change Password"),
              onTap: () {
                navigationRoute(context, route: "passwordScreen");
              },
            ),
          ],
        ),
      ),
    );
  }
}
