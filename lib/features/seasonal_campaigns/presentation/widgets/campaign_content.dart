import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_date_text.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_description_text.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_title_text.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaigns_dots_icon.dart';

class CampaignContent extends StatelessWidget {
  final String title;
  final String desc;
  final String date;

  const CampaignContent({
    Key? key,
    required this.title,
    required this.desc,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        const CampaignDotsIcon(),
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: CampaignTitleText(title: title),
        ),
        SizedBox(height: 11.h),
        CampaignDescriptionText(desc: desc),
        SizedBox(height: 8.h),
        Spacer(),
        CampaignDateText(date: date),
        SizedBox(height: 10.h),
      ],
    );
  }
}
