import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/presentation/build_seasonal_widget.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';

// ignore: must_be_immutable
class CurrentNonSeasonalCampaignsScreen extends StatelessWidget {
  final List<Campains>? campaigns;

   CurrentNonSeasonalCampaignsScreen({this.campaigns});


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
          child: SvgPicture.asset(
            AppAssets.greenLifeMakerLogo,
          )));

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
            AppStrings.orphan,
            style: TextStyle(
                color: AppColors.greenColor2,
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
        ],
      );
}
