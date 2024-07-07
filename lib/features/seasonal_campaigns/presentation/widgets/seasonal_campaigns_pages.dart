import 'package:flutter/material.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/pages/current_seasonal_campaigns.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/pages/previous_seasonal_campaigns.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/pages/upcoming_seasonal_campaigns.dart';

class SeasonalCampaignsPages extends StatelessWidget {
  final int index;
  const SeasonalCampaignsPages({
    super.key,
    required this.seasonalCampaignsCubit, required this.index,
  });

  final SeasonalCampaignsCubit seasonalCampaignsCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PageView(
          physics: const BouncingScrollPhysics(),
          controller: seasonalCampaignsCubit.pageController,
          onPageChanged: (index) {
            seasonalCampaignsCubit.changCurrentPage(index);
          },
          children: [
            PreviousSeasonalCampaignsScreen(
                campaigns:
                seasonalCampaignsCubit.seasonalCampaignsModel?.pastCampaigns),
            CurrentSeasonalCampaignsScreen(
                campaigns: seasonalCampaignsCubit
                    .seasonalCampaignsModel?.currentCampaigns),
            UpcomingSeasonalCampaigns(
                campaigns:
                seasonalCampaignsCubit.seasonalCampaignsModel?.nextCampaigns),
          ],
        ));
  }
}
