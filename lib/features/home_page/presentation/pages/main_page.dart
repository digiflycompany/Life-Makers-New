import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/card_states.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/cards_cubit.dart';
import 'package:life_makers/features/home_page/cubit/emergency_campaigns_cubit.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/home_app_bar.dart';
import 'package:life_makers/features/home_page/cubit/home_calender_cubit.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/home_page/presentation/pages/home_calender_details_screen.dart';
import 'package:life_makers/features/home_page/presentation/pages/news_details.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/user_details_card.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:page_transition/page_transition.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late EmergencyCampaignsCubit emergencyCampaignsCubit;
  late HomeCalenderCubit homeCalenderCubit;
  late CardCubit cardCubit;
  @override
  void initState() {
    emergencyCampaignsCubit = context.read<EmergencyCampaignsCubit>();
    homeCalenderCubit = context.read<HomeCalenderCubit>();
    emergencyCampaignsCubit.getEmergencyCampaignsData();
    homeCalenderCubit.getHomeCalender();
    cardCubit = context.read<CardCubit>();
    cardCubit.GetCurrentJoinedCampaignsAndOpp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor3,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity,50.h),
            child: HomeAppBar()),
        body: BlocBuilder<CardCubit, CardStates>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  const UserDetailsCard(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: SizedBox(
                        height: 81.h,
                        child:
                            BlocBuilder<EmergencyCampaignsCubit, CubitBaseState>(
                          builder: (context, state) {
                            if (state == CubitBaseState.done) {
                              if (emergencyCampaignsCubit.emergencyCampaignModel
                                      ?.campaigns?.isNotEmpty ==
                                  true)
                                return Column(
                                  children: [
                                    Flexible(
                                      child: PageView.builder(
                                        reverse: true,
                                        controller: _pageController,
                                        itemCount: emergencyCampaignsCubit
                                                .emergencyCampaignModel
                                                ?.campaigns
                                                ?.length ??
                                            0, // Adjust the number of items based on your ListView
                                        onPageChanged: (int page) {
                                          setState(() {
                                            _currentPage = page;
                                          });
                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return newsSample(
                                              campaigns: emergencyCampaignsCubit
                                                  .emergencyCampaignModel
                                                  ?.campaigns![index]);
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dotsIndicator(
                                        length: emergencyCampaignsCubit
                                                .emergencyCampaignModel
                                                ?.campaigns
                                                ?.length ??
                                            0),
                                  ],
                                );
                              else
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.greyColor2,
                                      borderRadius: BorderRadius.circular(7.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'لا يوجد حملات طارئة',
                                          maxLines: 2,
                                          textDirection: TextDirection.rtl,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: FontFamilies.alexandria,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10.4,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, left: 5),
                                          child: SvgPicture.asset(
                                              'assets/svg/empty5.svg'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                            } else if (state == CubitBaseState.loading ) {
                              return Center(
                                  child: CircularProgressIndicator.adaptive(
                              ));
                            }
                            return SizedBox.shrink();
                          },
                        )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: BlocBuilder<HomeCalenderCubit, CubitBaseState>(
                        builder: (context, state) {
                      if (state == CubitBaseState.done) {
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeCalenderCubit
                                .homeCalenderModel?.calender?.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return buildHomeCalenderItem(
                                  calender: homeCalenderCubit
                                      .homeCalenderModel?.calender?[index]);
                            });
                      } else if (state == CubitBaseState.loading) {
                        return Center(
                            child: CircularProgressIndicator.adaptive(
                        ));
                      }
                      return SizedBox.shrink();
                    }),
                  ),
                  SizedBox(height: 96.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  newsText({required String text}) {
    return Padding(
      padding: EdgeInsets.only(top: 13.h, right: 4.w),
      child: Text(
        text,
        maxLines: 2,
        textDirection: TextDirection.rtl,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          height: 2.h,
          color: Colors.white,
          fontFamily: FontFamilies.alexandria,
          fontWeight: FontWeight.w400,
          fontSize: 10.4,
        ),
      ),
    );
  }

  get infoIcon => Padding(
        padding: EdgeInsets.only(right: 9.w, top: 23.h),
        child: SvgPicture.asset(
          AppAssets.urgentNewsIcon,
          width: 22.w,
          height: 22.h,
        ),
      );

  buildHomeCalenderItem({required Calender? calender}) => InkWell(
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 400),
                  child: HomeCalenderDetailsScreen(calender: calender)));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          height: 105.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 250.w,
                child: Text(
                  '${calender?.name}',
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                  style: TextStyle(
                      height: 2.h,
                      color: Colors.black,
                      fontFamily: FontFamilies.alexandria,
                      fontWeight: FontWeight.w400,
                      fontSize: 11),
                ),
              ),
              SizedBox(width: 12.w),
              Padding(
                padding: EdgeInsets.only(right: 13.5.w),
                child: CircleAvatar(
                  backgroundColor: AppColors.blueColor,
                  radius: 35.r,
                  child: Text(
                    '${calender?.date}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamilies.alexandria),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  newsSample({required Campaigns? campaigns}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 400),
                child: NewsDetails(campains: campaigns)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 4.w, right: 4.w),
        width: double.infinity,
        height: 71.h,
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            newsText(text: campaigns!.name!),
            SizedBox(
              width: 5.w,
            ),
            infoIcon,
          ],
        ),
      ),
    );
  }

  Widget dotsIndicator({
    required int length,
  }) =>
      Directionality(
        textDirection: TextDirection.rtl,
        child: DotsIndicator(
          dotsCount: length,
          position: _currentPage,
          decorator: DotsDecorator(
            color: Colors.red.shade300,
            activeColor: Colors.red.shade300,
            size: const Size.square(6.0),
            activeSize: Size(39.0.w, 6),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            spacing: const EdgeInsets.all(1),
          ),
        ),
      );
}
