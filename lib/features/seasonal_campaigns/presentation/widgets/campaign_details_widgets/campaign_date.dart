import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';

class CampaignDate extends StatelessWidget {
  final Campaigns? campaignDetails;
  const CampaignDate({super.key, required this.campaignDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h,bottom:15.h),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SvgPicture.asset(AppAssets.calendarIcon, width: 14),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${campaignDetails?.startAt}'.split(' ').first,
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: FontFamilies.alexandria,
                  fontWeight: FontWeight.w400,
                  fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
