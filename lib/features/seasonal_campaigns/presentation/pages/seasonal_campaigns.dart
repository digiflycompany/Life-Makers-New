import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/widgets/custom_appbar.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_states.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/banners.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/custom_tab_bar.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/seasonal_campaigns_pages.dart';

class SeasonalCampaignsScreen extends StatelessWidget {
  final int index;

  const SeasonalCampaignsScreen({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SeasonalCampaignsCubit>(
      create: (BuildContext context) => SeasonalCampaignsCubit(index)..getSeasonalCampaignsRepo(context: context),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 50.h),
            child: CustomAppBar(AppStrings.seasonalCampaigns)),
        body: SafeArea(
          child: Column(
            children: [
              CustomBanners(),
              SizedBox(height: 20.h),
              CustomTabBar(),
              SizedBox(height: 11.h),
              BlocBuilder<SeasonalCampaignsCubit, SeasonalCampaignsStates>(
                  builder:
                      (BuildContext context, SeasonalCampaignsStates state) {
                    SeasonalCampaignsCubit seasonalCampaignsCubit = context.read<SeasonalCampaignsCubit>();
                    if (seasonalCampaignsCubit.seasonalCampaignsModel == null) {
                      return Expanded(child: Center(child: CircularProgressIndicator()));
                    } else  {
                      return SeasonalCampaignsPages(
                        seasonalCampaignsCubit: seasonalCampaignsCubit, index: index,
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
