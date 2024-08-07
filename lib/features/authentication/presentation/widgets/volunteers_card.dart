import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app_fonts.dart';

class VolunteerContainer extends StatelessWidget {
  final String itemName;

  VolunteerContainer({required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 117.w,
      height: 49.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.r),
        color: Colors.white70,
        border: Border.all(
          color: AppColors.blueColor,
          width: 2.0,
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: Text(
            itemName,
            style: TextStyle(
              color: AppColors.blueColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamilies.alexandria,
            ),
          ),
        ),
      ),
    );
  }
}