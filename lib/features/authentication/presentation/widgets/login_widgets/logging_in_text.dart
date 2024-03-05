import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

class LoggingInText extends StatelessWidget {
  const LoggingInText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Text(
        AppStrings.loggingIn,
        style: TextStyle(
            color: AppColors.blueColor,
            fontFamily: FontFamilies.alexandria,
            fontSize: 15.sp
        ),
      ),
    );
  }
}
