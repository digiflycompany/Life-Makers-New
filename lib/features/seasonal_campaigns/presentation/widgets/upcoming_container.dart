import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';

class UpComingContainer extends StatelessWidget {
  const UpComingContainer({super.key, required this.seasonalCampaignsCubit});

  final SeasonalCampaignsCubit seasonalCampaignsCubit;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 43.h,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: seasonalCampaignsCubit.currentPage == 2 ? Colors.grey.shade300 : Colors.white,
              width: 1.w),
          left: BorderSide(
              color: seasonalCampaignsCubit.currentPage == 2 ? Colors.grey.shade300 : Colors.white,
              width: 1.w),
          right: BorderSide(
              color: seasonalCampaignsCubit.currentPage == 2 ? Colors.grey.shade300 : Colors.white,
              width: 1.w),
          bottom: BorderSide(
              color: seasonalCampaignsCubit.currentPage == 2 ? Colors.white : Colors.transparent,
              width: 2.5.w),
        ),
      ),
    );
  }
}
