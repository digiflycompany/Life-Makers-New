import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

class NoActivitiesText extends StatelessWidget {
  const NoActivitiesText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: Center(
        child: Text(
          AppStrings.noActivities,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamilies.alexandria,
          ),
        ),
      ),
    );
  }
}
