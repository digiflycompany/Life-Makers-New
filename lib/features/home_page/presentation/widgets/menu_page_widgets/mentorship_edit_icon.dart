import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';

class MentorShipEditIcon extends StatelessWidget {
  const MentorShipEditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: ()=> Routes.membershipControlPageRoute.moveTo,
      child: Padding(
        padding: EdgeInsets.only(left: 68.h),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            width: 160.w,
            height: 47.h,
            decoration: BoxDecoration(
                color: AppColors.greyColor2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.r),
                  bottomLeft: Radius.circular(6.r),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.settingsIcon),
                SizedBox(width: 11.w),
                Text(
                  AppStrings.membershipControl,
                  style: TextStyle(
                      fontFamily: FontFamilies.alexandria,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                      fontSize: 12.5.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
