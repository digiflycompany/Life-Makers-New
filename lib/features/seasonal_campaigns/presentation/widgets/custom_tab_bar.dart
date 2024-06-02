import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_states.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/custom_divider.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/tabs.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeasonalCampaignsCubit,SeasonalCampaignsStates>(
      listener: (BuildContext context, SeasonalCampaignsStates state) {  },
      builder: (BuildContext context, SeasonalCampaignsStates state) {
        final seasonalCampaignsCubit = context.read<SeasonalCampaignsCubit>();
        return Stack(
          children: [
            CustomDivider(),
            Tabs(seasonalCampaignsCubit: seasonalCampaignsCubit),
            Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 13.h),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      seasonalCampaignsCubit.changePageView(0);
                    },
                    child: Text(
                      AppStrings.past,
                      style: TextStyle(
                          color: seasonalCampaignsCubit.currentPage == 0
                              ? AppColors.orangeColor
                              : AppColors.greyColor3,
                          fontFamily: FontFamilies.alexandria,
                          fontWeight: seasonalCampaignsCubit.currentPage == 0 ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 11.5),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      seasonalCampaignsCubit.changePageView(1);
                    },
                    child: Text(
                      AppStrings.current,
                      style: TextStyle(
                          color: seasonalCampaignsCubit.currentPage == 1
                              ? AppColors.greenColor2
                              : AppColors.greyColor3,
                          fontFamily: FontFamilies.alexandria,
                          fontWeight: seasonalCampaignsCubit.currentPage == 1 ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 11.5),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      seasonalCampaignsCubit.changePageView(2);
                    },
                    child: Text(
                      AppStrings.upcoming,
                      style: TextStyle(
                          color: seasonalCampaignsCubit.currentPage == 2
                              ? AppColors.blueColor4
                              : AppColors.greyColor3,
                          fontFamily: FontFamilies.alexandria,
                          fontWeight: seasonalCampaignsCubit.currentPage == 2 ? FontWeight.w600 : FontWeight.w400,
                          fontSize: 11.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
