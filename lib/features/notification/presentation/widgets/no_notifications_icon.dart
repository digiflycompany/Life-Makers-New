import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/widgets/spacer.dart';

class NoNotificationIcon extends StatelessWidget {
  const NoNotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppAssets.noCampaignsImg),
          VerticalSpace(30.h),
          Text(
            AppStrings.noNotifications,
            style: TextStyle(
              color: AppColors.greyColor4,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          )
        ],
      ),
    );
  }
}
