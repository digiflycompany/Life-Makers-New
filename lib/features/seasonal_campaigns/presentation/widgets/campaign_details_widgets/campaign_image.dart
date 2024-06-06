import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';

class CampaignImage extends StatelessWidget {
  final Campaigns? campaignDetails;
  const CampaignImage({super.key, required this.campaignDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: AspectRatio(
          aspectRatio: 16/10,
          child: Image.network(
            campaignDetails!.photo!,
            fit: BoxFit.fill,
          )),
    );
  }
}
