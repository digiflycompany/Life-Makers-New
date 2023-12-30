import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/title_text.dart';
import 'package:life_makers/features/authentication/domain/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/domain/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/home_page/cubit/home_calender_cubit.dart';
import 'package:life_makers/features/home_page/presentation/pages/home_calender_details_screen.dart';
import 'package:life_makers/features/home_page/presentation/pages/news_details.dart';
import 'package:life_makers/features/home_page/presentation/pages/profile_screen.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../seasonal_campaigns/model/seasonal_campaigns_model.dart';
import '../../cubit/emergency_campaigns_cubit.dart';
import '../../data/models/home_calender_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isOpen = false;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool rankPopup = false;
  late EmergencyCampaignsCubit emergencyCampaignsCubit;
  late HomeCalenderCubit homeCalenderCubit;
  late SignUpCubit signUpCubit;
  @override
  void initState() {
    super.initState();
    emergencyCampaignsCubit = context.read<EmergencyCampaignsCubit>();
    homeCalenderCubit = context.read<HomeCalenderCubit>();
    signUpCubit=context.read<SignUpCubit>();
    signUpCubit.GetCurrentJoinedCampaignsAndOpp();
    emergencyCampaignsCubit.getEmergencyCampaignsData();
    homeCalenderCubit.getHomeCalender();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: GestureDetector(
          onTap: () {
            setState(() {
              rankPopup = false;
            });
          },
          child: Column(
            children: [
              header,
              SizedBox(height: 8.h),
              detailsCard,
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: SizedBox(
                    height: 81.h,
                    child: BlocBuilder<EmergencyCampaignsCubit, CubitBaseState>(
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
                                          campains: emergencyCampaignsCubit
                                              .emergencyCampaignModel
                                              ?.campaigns?[index]);
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
                              padding:  EdgeInsets.symmetric(horizontal: 8.w),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.greyContainerColor,
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      padding: const EdgeInsets.only(right: 15,left: 5),
                                      child: SvgPicture.asset('assets/svg/empty5.svg'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                        } else if (state == CubitBaseState.loading) {
                          return Center(
                              child: CircularProgressIndicator(color: AppColors.orangeBorderColor,));
                        }
                        return SizedBox.shrink();
                      },
                    )),
              ),
              SizedBox(height: 10.h,),

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
                    return Center(child: CircularProgressIndicator(color: AppColors.orangeBorderColor,));
                  }
                  return SizedBox.shrink();
                }),
              ),
              SizedBox(height: 96.h),
            ],
          ),
        ),
      ),
    );
  }

  get title => TitleText(text: AppStrings.mainPage);
  get menuIcon => InkWell(
        onTap: () {
          setState(() {
            rankPopup = false;
          });
          if (ZoomDrawer.of(context)!.isOpen()) {
            ZoomDrawer.of(context)!.close();
          } else {
            ZoomDrawer.of(context)!.open();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(
            AppAssets.menuIcon,
          ),
        ),
      );
  get header => Row(
        children: [
          SizedBox(
            width: 180.w,
          ),
          title,
          SizedBox(
            width: 115.w,
          ),
          menuIcon,
        ],
      );
  get dropDownIcon => GestureDetector(
        onTap: () {
          setState(() {
            rankPopup = true;
          });
        },
        child: Padding(
          padding: EdgeInsets.only(top: 70.h),
          child: SvgPicture.asset(
            AppAssets.dropDownIcon,
            width: 7.w,
            height: 7.h,
          ),
        ),
      );
  get crownIcon => GestureDetector(
        onTap: () {
          setState(() {
            rankPopup = true;
          });
        },
        child: Padding(
          padding: EdgeInsets.only(top: 64.h),
          child: Image.asset(AppAssets.crownPng),
        ),
      );
  get name => Padding(
        padding: EdgeInsets.only(left: 114.w, top: 20.h),
        child: Text(
          PreferencesHelper.getIsVisitor?'زائر':'${PreferencesHelper.getName}',
          style: TextStyle(
              color: Colors.white,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w500,
              fontSize: 13),
        ),
      );
  get progressLine => LinearPercentIndicator(
    width: 190,
    backgroundColor: const Color(0xffF1F1F1),
    progressColor: const Color(0xffF7936F),
    percent: 0,
    isRTL: true,
    lineHeight: 8,
    padding: EdgeInsets.zero,
    barRadius: const Radius.circular(5),
  );
  get nameAndProgress => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 10.h
          ),
          name,
          SizedBox(
            height: 20.h
          ),
          progressLine,
        ],
      );
  get circleAvatar => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Padding(
          padding: EdgeInsets.only(top: 19.h),
          child: CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.white,
              child:SvgPicture.asset(AppAssets.circleAvatar2)),
        ),
      );

  // get circleAvatar => Align(
  //   alignment: AlignmentDirectional.topEnd,
  //   child: Padding(
  //     padding: EdgeInsets.only(top: 19.h),
  //     child: CircleAvatar(
  //         radius: 40.r,
  //         backgroundColor: Colors.white,
  //         child: Text(
  //             PreferencesHelper.getIsVisitor?'':
  //             formatName(PreferencesHelper.getName))),
  //   ),
  // );
  get details => Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(width: 11.w),
          circleAvatar,
          SizedBox(
            width: 10.w,
          ),
          nameAndProgress,
          SizedBox(
            width: 10.w,
          ),
          //crownIcon,
         // SizedBox(width: 5.w),
          //dropDownIcon,
        ],
      );
  get arrowIcon => Padding(
        padding: EdgeInsets.only(top: 3.h),
        child: SvgPicture.asset(
          AppAssets.arrowIcon,
          width: 10.w,
          height: 10.h,
        ),
      );
  get moreText => const Text(
        AppStrings.more,
        style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamilies.alexandria),
      );
  get activitiesText => const Text(
        AppStrings.activities,
        style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamilies.alexandria),
      );
  get activitiesAndMore => Row(
        children: [
          SizedBox(
            width: 12.w,
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 400),
                      child: ProfileScreen(hasBackButton: true,)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  arrowIcon,
                  SizedBox(
                    width: 5.w,
                  ),
                  moreText,
                ],
              ),
            ),
          ),
          SizedBox(
            width: 228.w,
          ),
          activitiesText,
        ],
      );
  get upcomingText => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, top: 4.h),
          child: const Text(
            AppStrings.upcoming,
            style: TextStyle(
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w700,
                color: AppColors.blueTextColor,
                fontSize: 7),
          ),
        ),
      );
  get educationText => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: const Text(
            AppStrings.education,
            style: TextStyle(
                color: AppColors.blueTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamilies.alexandria),
          ),
        ),
      );
  get upcomingCard => Container(
    width: 117.w,
    height: 49.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(23.r),
      color: Colors.white70,
      border: Border.all(
        color: AppColors.blueTextColor,
        width: 2.0, // Adjust the border width as needed
      ),
    ),
    child: Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: const Text(
              AppStrings.education,
              style: TextStyle(
                  color: AppColors.blueTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamilies.alexandria),
            ),
          ),
        ),
      ],
    ),
  );
  get currentText => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, top: 4.h),
          child: const Text(
            AppStrings.current,
            style: TextStyle(
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w700,
                color: AppColors.greenTextColor,
                fontSize: 7),
          ),
        ),
      );
  get palestineText => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.only(right: 7.w, bottom: 2.h),
          child: const Text(
            AppStrings.palestine,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                color: AppColors.greenTextColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamilies.alexandria),
          ),
        ),
      );
  get currentPalestineCard => InkWell(
        onTap: () {
          setState(() {
            rankPopup = false;
          });
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.fade,
          //         duration: const Duration(milliseconds: 400),
          //         child: CampaignDetailsScreen()));
        },
        child: Container(
          width: 117.w,
          height: 49.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            color: Colors.white70,
            border: Border.all(
              color: AppColors.greenBorderColor,
              width: 2.0, // Adjust the border width as needed
            ),
          ),
          child: Stack(
            children: [
              currentText,
              palestineText,
            ],
          ),
        ),
      );
  get currentText2 => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, top: 4.h),
          child: const Text(
            AppStrings.current,
            style: TextStyle(
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w700,
                color: AppColors.greenTextColor,
                fontSize: 7),
          ),
        ),
      );
  get previousText => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: EdgeInsets.only(left: 8.w, top: 4.h),
          child: const Text(
            AppStrings.past,
            style: TextStyle(
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w700,
                color: AppColors.orangeBorderColor,
                fontSize: 7),
          ),
        ),
      );
  get orphanText => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: const Text(
            AppStrings.orphan,
            style: TextStyle(
                color: AppColors.greenTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamilies.alexandria),
          ),
        ),
      );
  get previousOrphanText => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.only(right: 5.w),
          child: const Text(
            AppStrings.orphan,
            style: TextStyle(
                color: AppColors.orangeBorderColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamilies.alexandria),
          ),
        ),
      );
  get currentOrphanCard => Container(
    width: 117.w,
    height: 49.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(23.r),
      color: Colors.white70,
      border: Border.all(
        color: AppColors.greenBorderColor,
        width: 2.0, // Adjust the border width as needed
      ),
    ),
    child: Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: const Text(
              AppStrings.orphan,
              style: TextStyle(
                  color: AppColors.greenTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamilies.alexandria),
            ),
          ),
        ),
      ],
    ),
  );
  get previousOrphanCard => InkWell(
        onTap: () {
          setState(() {
            rankPopup = false;
          });
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.fade,
          //         duration: const Duration(milliseconds: 400),
          //         child: CampaignDetailsScreen()));
        },
        child: Container(
          width: 117.w,
          height: 49.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23.r),
            color: Colors.white70,
            border: Border.all(
              color: AppColors.orangeBorderColor,
              width: 2.0, // Adjust the border width as needed
            ),
          ),
          child: Column(
            children: [
              previousText,
              previousOrphanText,
            ],
          ),
        ),
      );
  get cards => Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SizedBox(
          height: 49.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            children: [
              Container(
                width: 117.w,
                height: 49.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23.r),
                  color: Colors.white70,
                  border: Border.all(
                    color: AppColors.greenBorderColor,
                    width: 2.0, // Adjust the border width as needed
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: const Text(
                      AppStrings.orphan,
                      style: TextStyle(
                          color: AppColors.greenTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamilies.alexandria),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              Container(
                width: 117.w,
                height: 49.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23.r),
                  color: Colors.white70,
                  border: Border.all(
                    color: AppColors.blueTextColor,
                    width: 2.0, // Adjust the border width as needed
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: const Text(
                      AppStrings.education,
                      style: TextStyle(
                          color: AppColors.blueTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamilies.alexandria),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  get detailsCard => Container(
      width: 376.w,
      height: 231.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          colors: [
            AppColors.gradientColor1,
            AppColors.gradientColor2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              details,
              SizedBox(
                height: 16.h,
              ),
              activitiesAndMore,
              SizedBox(
                height: 9.h,
              ),
              BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {},
               builder: (context, state) {
               return Row(
                children: [
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: signUpCubit.currentJoinedCampaignsAndOpp?.currentCampaigns?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                          width: 117.w,
                          height: 49.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.r),
                            color: Colors.white70,
                            border: Border.all(
                              color: AppColors.greenBorderColor,
                              width: 2.0, // Adjust the border width as needed
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child:  Text(
                                "${signUpCubit.currentJoinedCampaignsAndOpp?.currentCampaigns![index].name}",
                                style: TextStyle(
                                    color: AppColors.greenTextColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamilies.alexandria),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: signUpCubit.currentJoinedCampaignsAndOpp?.currentCampaigns?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: SizedBox(
                          height: 49.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            children: [
                              Container(
                                width: 117.w,
                                height: 49.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23.r),
                                  color: Colors.white70,
                                  border: Border.all(
                                    color: AppColors.greenBorderColor,
                                    width: 2.0, // Adjust the border width as needed
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5.w),
                                    child: const Text(
                                      AppStrings.orphan,
                                      style: TextStyle(
                                          color: AppColors.greenTextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamilies.alexandria),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Container(
                                width: 117.w,
                                height: 49.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23.r),
                                  color: Colors.white70,
                                  border: Border.all(
                                    color: AppColors.blueTextColor,
                                    width: 2.0, // Adjust the border width as needed
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 5.w),
                                    child: const Text(
                                      AppStrings.education,
                                      style: TextStyle(
                                          color: AppColors.blueTextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamilies.alexandria),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              );
  },
),
            ],
          ),
          if (rankPopup == true)
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.only(left: 35.5.w, top: 18.h),
                child: Container(
                  height: 124.h,
                  width: 38.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(AppAssets.kingIcon),
                      CircleAvatar(
                          backgroundColor: AppColors.darkBlueColor,
                          radius: 16.r,
                          child: Image.asset(AppAssets.crownPng)),
                      Image.asset(AppAssets.diamondIcon),
                      Image.asset(AppAssets.lowLevelIcon),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            top: 17,
            left:17,
            child: InkWell(
                onTap: () {
                  if (!PreferencesHelper.getIsVisitor)
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff0E395E),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.only(top: 30),
                              // margin: const EdgeInsets.only(bottom: 22),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: SvgPicture.network(
                                        '${PreferencesHelper.getUserModel?.user?.qrCode}'),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'امسح هنا',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Alexandria',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SvgPicture.asset(
                                          'assets/svg/tie.svg'),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                ],
                              ),
                            ),
                          );
                        });
                },
                child: SvgPicture.asset(
                  AppAssets.qrCode2,
                )),
          )
        ],
      ));
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
                  backgroundColor: AppColors.darkBlueColor,
                  radius: 35.r,
                  child: Text(
                    '${calender?.date}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamilies.alexandria),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  newsSample({required Campains? campains}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          rankPopup = false;
        });
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 400),
                child: NewsDetails(campains: campains)));
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
            newsText(text: campains!.name!),
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
