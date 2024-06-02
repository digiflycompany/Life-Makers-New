import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserNameAndProgressLine extends StatelessWidget {
  const UserNameAndProgressLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Text(
              PreferencesHelper.getIsVisitor
                  ? 'زائر'
                  : '${PreferencesHelper.getName}',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamilies.alexandria,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: LinearPercentIndicator(
              width: 190,
              backgroundColor: const Color(0xffF1F1F1),
              progressColor: const Color(0xffF7936F),
              percent: 0,
              isRTL: true,
              lineHeight: 8,
              padding: EdgeInsets.zero,
              barRadius: const Radius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
