import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

class CampaignMissionText extends StatelessWidget {
  const CampaignMissionText({super.key,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w,bottom: 20.h),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          AppStrings.campaignMissions,
          style: TextStyle(
              color: Colors.black,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp
          ),
        ),
      ),
    );
  }
}
