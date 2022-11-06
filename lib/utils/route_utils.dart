import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigationRoute(BuildContext context, {required String route}) async {
  Navigator.pushNamed(
    context,
    "/$route",
  );
}

void replacedNavigation(BuildContext context, {required String route}) async {
  Navigator.pushReplacementNamed(context, "/$route");
}
