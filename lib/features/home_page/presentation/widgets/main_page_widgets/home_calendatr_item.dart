import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';
import 'package:life_makers/features/home_page/presentation/pages/home_calender_details_screen.dart';
import 'package:page_transition/page_transition.dart';

class HomeCalenderItem extends StatelessWidget {
  final Calender? calender;

  const HomeCalenderItem({
    Key? key,
    required this.calender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400),
            child: HomeCalenderDetailsScreen(calender: calender),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 105.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 250.w,
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
            ),
            SizedBox(width: 12.w),
            Padding(
              padding: EdgeInsets.only(right: 13.5.w),
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
            ),
          ],
        ),
      ),
    );
  }
}
