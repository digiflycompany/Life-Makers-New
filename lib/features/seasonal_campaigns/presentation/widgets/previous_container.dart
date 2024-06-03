import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';

class PreviousContainer extends StatelessWidget {
  const PreviousContainer({super.key, required this.seasonalCampaignsCubit});

  final SeasonalCampaignsCubit seasonalCampaignsCubit;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        seasonalCampaignsCubit.changePageView(0);
      },
      child: Container(
        width: 70.w,
        height: 43.h,
        decoration: BoxDecoration(
          border: seasonalCampaignsCubit.currentPage == 0 ? Border(
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
      ),
    );
  }
}
