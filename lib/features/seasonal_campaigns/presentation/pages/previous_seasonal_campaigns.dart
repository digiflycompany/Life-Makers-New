import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/campaign_details_screen.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:page_transition/page_transition.dart';

import '../build_seasonal_widget.dart';

class PreviousSeasonalCampaignsScreen extends StatelessWidget {
  PreviousSeasonalCampaignsScreen({super.key, this.campaigns});

  final List<Campains>? campaigns;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: buildCampaignGridView(
          context: context,
          campaigns: campaigns
        ),
      ),
    );
  }

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
  Widget titleText({required String title}) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: EdgeInsets.only(right: 0.w,top: 5),
      child: Text(
        title,
        style: TextStyle(
            color: AppColors.orangeColor,
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
    ),
  );
  Widget descriptionText({required String desc}) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Padding(
      padding: EdgeInsets.only(right: 0.w),
      child: Text(
        desc,
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
  Widget dateText({required String date}) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      calendarIcon,
       Padding(
        padding:   EdgeInsets.only(right: 5.w,left: 30.w),
        child: Text(
          date,
          style: TextStyle(
              color: Colors.grey,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w400,
              fontSize: 10),
        ),
      ),
     ],
  );

  Widget content({
    required String title,
    required String desc,
    required String date,
  }) =>
      Column(
        children: [
          SizedBox(height: 12.h),
          dotsIcon,
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: titleText(title: title),
          ),
          SizedBox(height: 11.h),
          descriptionText(desc: desc),
          SizedBox(height: 8.h),
          Spacer(),
          dateText(date: date),
          SizedBox(height: 10.h),

        ],
      );

Widget CampaignDetailsWidget({Campains? campaignDetails,required Color color,
  required BuildContext context,
required Color borderColor,
}) => InkWell(
  onTap: (){
    Navigator.push(context, PageTransition(
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 400),
      child:CampaignDetailsScreen(campaignDetails: campaignDetails)
    ));
  },
  child: Container(

    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: borderColor, width: 1.7.w),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Padding(
      padding: EdgeInsets.only(right: 13.w),
      child: Stack(
        children: [
          logoImg,
          content(
              title: '${campaignDetails?.name}',
              desc: '${campaignDetails?.details}',
              date: '${campaignDetails?.startAt}'.split(' ').first),
        ],
      ),
    ),
  ),
);


Widget AllCampaignDetailsWidget({Campains? campaignDetails,required Color color,
  required BuildContext context,
  required Color borderColor,
}) => InkWell(
  onTap: (){
    Navigator.push(context, PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 400),
        child:CampaignDetailsScreen(campaignDetails: campaignDetails)
    ));
  },
  child: Container(
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: borderColor, width: 1.7.w),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Padding(
      padding: EdgeInsets.only(right: 13.w),
      child: Stack(
        children: [
          logoImg,
          content(
              title: '${campaignDetails?.name}',
              desc: '${campaignDetails?.details}',
              date: '${campaignDetails?.startAt}'),
        ],
      ),
    ),
  ),
);
