import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/current_container.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/previous_container.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/upcoming_container.dart';

class Tabs extends StatelessWidget {
  const Tabs({super.key, required this.seasonalCampaignsCubit});

  final SeasonalCampaignsCubit seasonalCampaignsCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 13.w,
        right: 12.w,
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PreviousContainer(seasonalCampaignsCubit: seasonalCampaignsCubit),
          CurrentContainer(seasonalCampaignsCubit: seasonalCampaignsCubit),
          UpComingContainer(seasonalCampaignsCubit: seasonalCampaignsCubit),
        ],
      ),
    );
  }
}
