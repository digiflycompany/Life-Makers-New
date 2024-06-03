import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

class MentorShipEditIcon extends StatelessWidget {
  const MentorShipEditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        // Navigator.push(
        //     context,
        //     PageTransition(
        //         type: PageTransitionType.fade,
        //         duration: const Duration(milliseconds: 400),
        //         child: const MembershipControl()));

      },
      child: Padding(
        padding: const EdgeInsets.only(left: 68),
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
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
                Text(
                  AppStrings.membershipControl,
                  style: TextStyle(
                      fontFamily: FontFamilies.alexandria,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                      fontSize: 12.5),
                ),
                SizedBox(width: 11.w),
                SvgPicture.asset(AppAssets.settingsIcon),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
