import 'package:flutter/material.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';

class CampaignImage extends StatelessWidget {
  final Campaigns? campaignDetails;
  const CampaignImage({super.key, required this.campaignDetails});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16/10,
        child: Image.network(
          campaignDetails!.photo!,
          fit: BoxFit.fill,
        ));
  }
}
