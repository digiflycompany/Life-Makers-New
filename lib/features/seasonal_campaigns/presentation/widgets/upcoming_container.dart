import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';

class UpComingContainer extends StatelessWidget {
  const UpComingContainer({super.key, required this.seasonalCampaignsCubit});

  final SeasonalCampaignsCubit seasonalCampaignsCubit;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        seasonalCampaignsCubit.changePageView(2);
      },
      child: Container(
        width: 70.w,
        height: 43.h,
        decoration: BoxDecoration(
          border: seasonalCampaignsCubit.currentPage == 2 ? Border(
            top: BorderSide(
                color: Colors.grey.shade300,
                width: 1.w),
            left: BorderSide(
                color: Colors.grey.shade300,
                width: 1.w),
            right: BorderSide(
                color: Colors.grey.shade300,
                width: 1.w),
            bottom: BorderSide(
                color: Colors.white ,
                width: 1.w),
          ): Border(
            bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.w),
          ),
        ),
        child: Center(
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
      ),
    );
  }
}
