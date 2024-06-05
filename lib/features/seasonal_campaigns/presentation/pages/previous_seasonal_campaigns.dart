import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/build_seasonal_widget.dart';

class PreviousSeasonalCampaignsScreen extends StatelessWidget {
  PreviousSeasonalCampaignsScreen({super.key, this.campaigns});

  final List<Campaigns>? campaigns;

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