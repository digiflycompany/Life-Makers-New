import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/campaign_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../model/seasonal_campaigns_model.dart';
import '../build_seasonal_widget.dart';

class CurrentSeasonalCampaignsScreen extends StatefulWidget {
 final List<Campains>? campaigns;

  CurrentSeasonalCampaignsScreen({super.key, this.campaigns});

  @override
  State<CurrentSeasonalCampaignsScreen> createState() =>
      _CurrentSeasonalCampaignsScreenState();
}

class _CurrentSeasonalCampaignsScreenState
    extends State<CurrentSeasonalCampaignsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: buildCampaignGridView(context: context,campaigns: widget.campaigns),
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
                color: AppColors.greenTextColor,
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
  Widget previousSeasonalCampaigns(Campains? campaignDetails) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 600),
                  child:   CampaignDetailsScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.greenBackgroundColor,
            border: Border.all(color: AppColors.greenBorderColor, width: 1.6.w),
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
        ),
      );
}