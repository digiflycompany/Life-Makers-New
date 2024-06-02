import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/seasonal_campaigns_model.dart';
import '../build_seasonal_widget.dart';

class UpcomingSeasonalCampaigns extends StatelessWidget {
  final List<Campaigns>? campaigns;

  UpcomingSeasonalCampaigns({this.campaigns});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: buildCampaignGridView(
          context: context,
          campaigns: campaigns,
        ),
      ),
    );
  }
}
