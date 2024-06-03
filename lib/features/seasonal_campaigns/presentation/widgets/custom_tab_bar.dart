import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_states.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/tabs.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeasonalCampaignsCubit,SeasonalCampaignsStates>(
      listener: (BuildContext context, SeasonalCampaignsStates state) {  },
      builder: (BuildContext context, SeasonalCampaignsStates state) {
        final seasonalCampaignsCubit = context.read<SeasonalCampaignsCubit>();
        return Column(
          children: [
            Tabs(seasonalCampaignsCubit: seasonalCampaignsCubit),
          ],
        );
      },
    );
  }
}
