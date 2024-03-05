import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';

class LoggingInText extends StatelessWidget {
  const LoggingInText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: EdgeInsets.only(top: context.height20,bottom: context.height16),
        child: Text(
          AppStrings.loggingIn,
          style: TextStyle(
              color: AppColors.blueColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
