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
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SeasonalCampaignsCubit>(
      create: (BuildContext context) => SeasonalCampaignsCubit()..getSeasonalCampaignsRepo(context: context),
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
                        seasonalCampaignsCubit: seasonalCampaignsCubit,
                      );
                    }
                    // else
                    //   return SizedBox.shrink();
                  }),
            ],
          ),
        ),
      ),
    );
  }



  // get title => TitleText(text: AppStrings.seasonalCampaigns);

  // get popUpIcon => GestureDetector(
  //       onTap: () {
  //         Navigator.pop(context);
  //       },
  //       child: SvgPicture.asset(
  //         AppAssets.popUpIcon,
  //       ),
  //     );

  // get header => Row(
  //       children: [
  //         SizedBox(
  //           width: 156.w,
  //         ),
  //         title,
  //         SizedBox(
  //           width: 115.w,
  //         ),
  //         popUpIcon,
  //       ],
  //     );


  // get previousContainer => Container(
  //       width: 70.w,
  //       height: 43.h,
  //       decoration: BoxDecoration(
  //         border: Border(
  //           top: BorderSide(
  //               color: _currentPage == 0 ? Colors.grey.shade300 : Colors.white,
  //               width: 1.w),
  //           left: BorderSide(
  //               color: _currentPage == 0 ? Colors.grey.shade300 : Colors.white,
  //               width: 1.w),
  //           right: BorderSide(
  //               color: _currentPage == 0 ? Colors.grey.shade300 : Colors.white,
  //               width: 1.w),
  //           bottom: BorderSide(
  //               color: _currentPage == 0 ? Colors.white : Colors.transparent,
  //               width: 2.5.w),
  //         ),
  //       ),
  //     );

  // get currentContainer => Container(
  //       width: 70.w,
  //       height: 43.h,
  //       decoration: BoxDecoration(
  //         border: Border(
  //           top: BorderSide(
  //               color: _currentPage == 1 ? Colors.grey.shade300 : Colors.white,
  //               width: 1.w),
  //           left: BorderSide(
  //               color: _currentPage == 1 ? Colors.grey.shade300 : Colors.white,
  //               width: 1.w),
  //           right: BorderSide(
  //               color: _currentPage == 1 ? Colors.grey.shade300 : Colors.white,
  //               width: 1.w),
  //           bottom: BorderSide(
  //               color: _currentPage == 1 ? Colors.white : Colors.transparent,
  //               width: 2.5.w),
  //         ),
  //       ),
  //     );

  // get upcomingContainer => Container(
  //       width: 70.w,
  //       height: 43.h,
  //       decoration: BoxDecoration(
  //         border: Border(
  //           top: BorderSide(
  //               color: _currentPage == 2 ? Colors.grey.shade300 : Colors.white,
  //               width: 1.w),
  //           left: BorderSide(
  //               color: _currentPage == 2 ? Colors.grey.shade300 : Colors.white,
  //               width: 1.w),
  //           right: BorderSide(
  //               color: _currentPage == 2 ? Colors.grey.shade300 : Colors.white,
  //               width: 1.w),
  //           bottom: BorderSide(
  //               color: _currentPage == 2 ? Colors.white : Colors.transparent,
  //               width: 2.5.w),
  //         ),
  //       ),
  //     );

  // get tabs => Padding(
  //       padding: EdgeInsets.only(
  //         left: 13.w,
  //         right: 12.w,
  //       ),
  //       child: Row(
  //         textDirection: TextDirection.rtl,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           previousContainer,
  //           currentContainer,
  //           upcomingContainer,
  //         ],
  //       ),
  //     );

  // get previousText => GestureDetector(
  //       onTap: () {
  //         _changePage(0);
  //       },
  //       child: Text(
  //         AppStrings.past,
  //         style: TextStyle(
  //             color: _currentPage == 0
  //                 ? AppColors.orangeColor
  //                 : AppColors.greyColor3,
  //             fontFamily: FontFamilies.alexandria,
  //             fontWeight: _currentPage == 0 ? FontWeight.w600 : FontWeight.w400,
  //             fontSize: 11.5),
  //       ),
  //     );

  // get currentText => GestureDetector(
  //       onTap: () {
  //         _changePage(1);
  //       },
  //       child: Text(
  //         AppStrings.current,
  //         style: TextStyle(
  //             color: _currentPage == 1
  //                 ? AppColors.greenColor2
  //                 : AppColors.greyColor3,
  //             fontFamily: FontFamilies.alexandria,
  //             fontWeight: _currentPage == 1 ? FontWeight.w600 : FontWeight.w400,
  //             fontSize: 11.5),
  //       ),
  //     );

  // get upcomingText => GestureDetector(
  //       onTap: () {
  //         _changePage(2);
  //       },
  //       child: Text(
  //         AppStrings.upcoming,
  //         style: TextStyle(
  //             color: _currentPage == 2
  //                 ? AppColors.blueColor4
  //                 : AppColors.greyColor3,
  //             fontFamily: FontFamilies.alexandria,
  //             fontWeight: _currentPage == 2 ? FontWeight.w600 : FontWeight.w400,
  //             fontSize: 11.5),
  //       ),
  //     );

  // get texts => Padding(
  //       padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 13.h),
  //       child: Row(
  //         textDirection: TextDirection.rtl,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           previousText,
  //           currentText,
  //           upcomingText,
  //         ],
  //       ),
  //     );

  // get tabBar => Stack(
  //       children: [
  //         CustomDivider(),
  //         tabs,
  //         texts,
  //       ],
  //     );

  // Widget pages({
  //   List<Campains>? previousCampaigns,
  //   List<Campains>? currentCampaigns,
  //   List<Campains>? upcomingCampaigns,
  // }) =>
  //     Expanded(
  //         child: PageView(
  //       physics: const BouncingScrollPhysics(),
  //       reverse: true,
  //       controller: pageController,
  //       onPageChanged: (int page) {
  //         setState(() {
  //           _currentPage = page;
  //         });
  //       },
  //       children: [
  //         PreviousSeasonalCampaignsScreen(campaigns: previousCampaigns),
  //         CurrentSeasonalCampaignsScreen(campaigns: currentCampaigns),
  //         UpcomingSeasonalCampaigns(campaigns: upcomingCampaigns),
  //       ],
  //     ));


  // get firstText => Align(
  //       alignment: AlignmentDirectional.center,
  //       child: Padding(
  //         padding: EdgeInsets.only(top: 50.h),
  //         child: const Text(
  //           AppStrings.lifeMakers,
  //           textDirection: TextDirection.rtl,
  //           style: TextStyle(
  //               color: Colors.white,
  //               fontFamily: FontFamilies.alexandria,
  //               fontWeight: FontWeight.w700,
  //               fontSize: 13),
  //         ),
  //       ),
  //     );

  // get secondText => Align(
  //       alignment: AlignmentDirectional.center,
  //       child: Padding(
  //         padding: EdgeInsets.only(top: 75.h),
  //         child: const Text(
  //           AppStrings.becomeVolunteer,
  //           textDirection: TextDirection.rtl,
  //           style: TextStyle(
  //               color: Colors.white,
  //               fontFamily: FontFamilies.alexandria,
  //               fontWeight: FontWeight.w400,
  //               fontSize: 10),
  //         ),
  //       ),
  //     );

  // get banner => Stack(
  //       children: [
  //         img,
  //         firstText,
  //         secondText,
  //       ],
  //     );

}
