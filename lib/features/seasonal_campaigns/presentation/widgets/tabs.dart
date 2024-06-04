import 'package:flutter/material.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/current_container.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/previous_container.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/upcoming_container.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key, required this.seasonalCampaignsCubit});

  final SeasonalCampaignsCubit seasonalCampaignsCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 1,
          child: Divider(
            height: 0,
            thickness: 1,
          ),
        ),
        PreviousContainer(seasonalCampaignsCubit: seasonalCampaignsCubit),
        Expanded(
          flex: 2,
          child: Divider(
            height: 0,
            thickness: 1,
          ),
        ),
        CurrentContainer(seasonalCampaignsCubit: seasonalCampaignsCubit),
        Expanded(
          flex: 2,
          child: Divider(
            height: 0,
            thickness: 1,
          ),
        ),
        UpComingContainer(seasonalCampaignsCubit: seasonalCampaignsCubit),
        Expanded(
          flex: 1,
          child: Divider(
            height: 0,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
