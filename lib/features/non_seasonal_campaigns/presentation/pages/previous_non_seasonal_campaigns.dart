import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/build_seasonal_widget.dart';

import '../../../../core/utils/app-color.dart';

class PreviousNonSeasonalCampaignsScreen extends StatelessWidget {
  final List<Campains>? campaigns;

  PreviousNonSeasonalCampaignsScreen({this.campaigns});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: buildCampaignGridView(context: context, campaigns: campaigns),
      ),
    );
  }

  get logoImg => Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
        padding: EdgeInsets.only(left: 9.w, bottom: 6.h),
        child: SvgPicture.asset(AppAssets.orangeLifeMakerLogo),
      ));
  get dotsIcon => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: EdgeInsets.only(left: 13.w),
        child: SvgPicture.asset(
          AppAssets.dotsIcon,
          height: 13.h,
        ),
      ));
  get titleText => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: EdgeInsets.only(right: 0.w),
          child: const Text(
            AppStrings.education,
            style: TextStyle(
                color: AppColors.orangeColor,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w500,
                fontSize: 13.5),
          ),
        ),
      );
  get descriptionText => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: EdgeInsets.only(right: 0.w),
          child: const Text(
            AppStrings.dummyData,
            style: TextStyle(
                color: Colors.black,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w400,
                fontSize: 10,
                height: 1.56),
            textDirection: TextDirection.rtl,
            maxLines: 3,
          ),
        ),
      );
  get calendarIcon => SvgPicture.asset(
        AppAssets.calendarIcon,
        width: 12.w,
      );
  get dateText => Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: const Text(
          AppStrings.date,
          style: TextStyle(
              color: Colors.grey,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w400,
              fontSize: 9.5),
        ),
      );
  get date => Padding(
        padding: EdgeInsets.only(right: 4.5.w),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            calendarIcon,
            SizedBox(width: 4.w),
            dateText,
          ],
        ),
      );
  get content => Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          dotsIcon,
          titleText,
          SizedBox(
            height: 11.h,
          ),
          descriptionText,
          SizedBox(
            height: 8.h,
          ),
          date,
        ],
      );
  get previousSeasonalCampaigns => Container(
        decoration: BoxDecoration(
          color: AppColors.orangeColor2,
          border: Border.all(color: AppColors.orangeColor, width: 1.7.w),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: 13.w),
          child: Stack(
            children: [
              logoImg,
              content,
            ],
          ),
        ),
      );
}
