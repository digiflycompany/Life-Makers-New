import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../model/seasonal_campaigns_model.dart';
import '../build_seasonal_widget.dart';

class UpcomingSeasonalCampaigns extends StatelessWidget {
  final List<Campains>? campaigns;

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
