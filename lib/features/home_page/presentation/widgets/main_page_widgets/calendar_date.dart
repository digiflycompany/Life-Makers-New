import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';

class CalendarDate extends StatelessWidget {
  final Calender? calender;
  const CalendarDate({super.key, required this.calender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 13.5.w,left: 12.w),
      child: CircleAvatar(
        backgroundColor: AppColors.blueColor,
        radius: 35.r,
        child: Text(
          '${calender?.date}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 8.sp,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilies.alexandria,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
