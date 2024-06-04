import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';

class CalendarText extends StatelessWidget {
  final Calender? calender;
  const CalendarText({super.key, required this.calender});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        '${calender?.name}',
        textDirection: TextDirection.rtl,
        maxLines: 2,
        style: TextStyle(
          height: 2.h,
          color: Colors.black,
          fontFamily: FontFamilies.alexandria,
          fontWeight: FontWeight.w400,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
