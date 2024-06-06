import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_content.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_logo_img.dart';

class CampaignDetailsWidget extends StatelessWidget {
  final Campaigns? campaignDetails;
  final Color color;
  final Color borderColor;
  final BuildContext context;

  const CampaignDetailsWidget({
    Key? key,
    required this.campaignDetails,
    required this.color,
    required this.borderColor, required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       Routes.campaignDetailsPageRoute.pushWithData({'campaignDetails':campaignDetails});
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
              const CampaignLogoImg(),
              CampaignContent(
                title: campaignDetails?.name ?? '',
                desc: campaignDetails?.details ?? '',
                date: campaignDetails?.startAt?.split(' ').first ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
