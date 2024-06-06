import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';

class CampaignName extends StatelessWidget {
  final Campaigns? campaignDetails;
  const CampaignName({super.key, required this.campaignDetails});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        campaignDetails!.name!,
        style: TextStyle(
            color: Colors.black,
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w500,
            fontSize: 17.sp
        ),
      ),
    );
  }
}
