import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/widgets/custom_appbar.dart';
import 'package:life_makers/core/widgets/title_text.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/presentation/pages/previous_seasonal_campaigns.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/presentation/pages/upcoming_seasonal_campaigns.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

import '../../model/seasonal_campaigns_model.dart';
import 'current_seasonal_campaigns.dart';

class SeasonalCampaignsScreen extends StatefulWidget {
  const SeasonalCampaignsScreen({super.key});

  @override
  State<SeasonalCampaignsScreen> createState() =>
      _SeasonalCampaignsScreenState();
}

class _SeasonalCampaignsScreenState extends State<SeasonalCampaignsScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;

  late SeasonalCampaignsCubit seasonalCampaignsCubit;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    seasonalCampaignsCubit = context.read<SeasonalCampaignsCubit>();
    seasonalCampaignsCubit.getSeasonalCampaignsRepo(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50.h),
          child: CustomAppBar(AppStrings.seasonalCampaigns)),
      body: SafeArea(
        child: Column(
          children: [
            banner,
            SizedBox(height: 20.h),
            tabBar,
            SizedBox(height: 11.h),
            BlocBuilder<SeasonalCampaignsCubit, CubitBaseState>(
                builder: (context, state) {
              if (state == CubitBaseState.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state == CubitBaseState.done) {
                return pages(
                  currentCampaigns: seasonalCampaignsCubit
                      .seasonalCampaignsModel?.currentCampaigns,
                  previousCampaigns: seasonalCampaignsCubit
                      .seasonalCampaignsModel?.pastCampaigns,
                  upcomingCampaigns: seasonalCampaignsCubit
                      .seasonalCampaignsModel?.nextCampaigns,
                );
              } else
                return SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }

  void _changePage(int page) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  get title => TitleText(text: AppStrings.seasonalCampaigns);
  get popUpIcon => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          AppAssets.popUpIcon,
        ),
      );
  get header => Row(
        children: [
          SizedBox(
            width: 156.w,
          ),
          title,
          SizedBox(
            width: 115.w,
          ),
          popUpIcon,
        ],
      );
  get divider => Padding(
        padding: EdgeInsets.only(top: 33.h),
        child: Divider(
          thickness: 1.w,
        ),
      );
  get previousContainer => Container(
        width: 70.w,
        height: 43.h,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: _currentPage == 0 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            left: BorderSide(
                color: _currentPage == 0 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            right: BorderSide(
                color: _currentPage == 0 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            bottom: BorderSide(
                color: _currentPage == 0 ? Colors.white : Colors.transparent,
                width: 2.5.w),
          ),
        ),
      );
  get currentContainer => Container(
        width: 70.w,
        height: 43.h,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: _currentPage == 1 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            left: BorderSide(
                color: _currentPage == 1 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            right: BorderSide(
                color: _currentPage == 1 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            bottom: BorderSide(
                color: _currentPage == 1 ? Colors.white : Colors.transparent,
                width: 2.5.w),
          ),
        ),
      );
  get upcomingContainer => Container(
        width: 70.w,
        height: 43.h,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: _currentPage == 2 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            left: BorderSide(
                color: _currentPage == 2 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            right: BorderSide(
                color: _currentPage == 2 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            bottom: BorderSide(
                color: _currentPage == 2 ? Colors.white : Colors.transparent,
                width: 2.5.w),
          ),
        ),
      );
  get tabs => Padding(
        padding: EdgeInsets.only(
          left: 13.w,
          right: 12.w,
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            previousContainer,
            currentContainer,
            upcomingContainer,
          ],
        ),
      );
  get previousText => GestureDetector(
        onTap: () {
          _changePage(0);
        },
        child: Text(
          AppStrings.past,
          style: TextStyle(
              color: _currentPage == 0
                  ? AppColors.orangeColor
                  : AppColors.greyColor3,
              fontFamily: FontFamilies.alexandria,
              fontWeight: _currentPage == 0 ? FontWeight.w600 : FontWeight.w400,
              fontSize: 11.5),
        ),
      );
  get currentText => GestureDetector(
        onTap: () {
          _changePage(1);
        },
        child: Text(
          AppStrings.current,
          style: TextStyle(
              color: _currentPage == 1
                  ? AppColors.greenColor2
                  : AppColors.greyColor3,
              fontFamily: FontFamilies.alexandria,
              fontWeight: _currentPage == 1 ? FontWeight.w600 : FontWeight.w400,
              fontSize: 11.5),
        ),
      );
  get upcomingText => GestureDetector(
        onTap: () {
          _changePage(2);
        },
        child: Text(
          AppStrings.upcoming,
          style: TextStyle(
              color: _currentPage == 2
                  ? AppColors.blueColor
                  : AppColors.greyColor3,
              fontFamily: FontFamilies.alexandria,
              fontWeight: _currentPage == 2 ? FontWeight.w600 : FontWeight.w400,
              fontSize: 11.5),
        ),
      );
  get texts => Padding(
        padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 13.h),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            previousText,
            currentText,
            upcomingText,
          ],
        ),
      );
  get tabBar => Stack(
        children: [
          divider,
          tabs,
          texts,
        ],
      );
  Widget pages({
    List<Campaigns>? previousCampaigns,
    List<Campaigns>? currentCampaigns,
    List<Campaigns>? upcomingCampaigns,
  }) =>
      Expanded(
          child: PageView(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          PreviousSeasonalCampaignsScreen(campaigns: previousCampaigns),
          CurrentSeasonalCampaignsScreen(campaigns: currentCampaigns),
          UpcomingSeasonalCampaigns(campaigns: upcomingCampaigns),
        ],
      ));
  get img => Center(child: Image.asset(AppAssets.lifeMakerBanner));
  get firstText => Align(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: const Text(
            AppStrings.lifeMakers,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                color: Colors.white,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w700,
                fontSize: 13),
          ),
        ),
      );
  get secondText => Align(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: EdgeInsets.only(top: 75.h),
          child: const Text(
            AppStrings.becomeVolunteer,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                color: Colors.white,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w400,
                fontSize: 10),
          ),
        ),
      );
  get banner => Stack(
        children: [
          img,
          firstText,
          secondText,
        ],
      );
}
