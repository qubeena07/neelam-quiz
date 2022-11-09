import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/resources/app_colors.dart';

class CustomizeButton extends StatelessWidget {
  final String text;

  final VoidCallback onPress;
  const CustomizeButton({Key? key, required this.text, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
          height: 40,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.kPrimaryColor),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ));
  }
}
