import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';

class CampaignContent extends StatelessWidget {
  final Campaigns? campaignDetails;
  const CampaignContent({super.key, required this.campaignDetails});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom: 50.h),
      child: Text(
        "${campaignDetails?.details}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 11,
          fontFamily: FontFamilies.alexandria,
          height: 1.8.h,
        ),
        textAlign: TextAlign.start,
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
