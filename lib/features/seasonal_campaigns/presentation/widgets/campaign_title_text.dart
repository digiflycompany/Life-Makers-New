import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

class CampaignTitleText extends StatelessWidget {
  final String title;

  const CampaignTitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.only(right: 0, top: 5.h),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.orangeColor,
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
