import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/domain/card_cubit/card_states.dart';
import 'package:life_makers/features/authentication/domain/card_cubit/cards_cubit.dart';
import 'package:life_makers/features/campaign_details/cubit/all_campaigns_cubit.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/user_joined_current_campaigns.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/user_joined_previous_campaigns.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/user_joined_upcaoming_campaigns.dart';
import 'package:life_makers/features/edit_account/screens/edit_account_screen.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/widgets/user_joined_one_day_activity.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/widgets/user_joined_programs_card.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/widgets/user_joined_remote_tasks_card.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../authentication/domain/card_cubit/volunteer_card_details.dart';
import '../../../authentication/presentation/widgets/volunteers_card.dart';
import 'news_details.dart';

class ProfileScreen extends StatefulWidget {
  final bool? hasBackButton;
  const ProfileScreen({Key? key, this.hasBackButton}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PageController _pageController;
  late PageController _pageController2;
  int _currentPage = 1;
  int _currentPage2 = 0;
  late VolunteerCubit volunteerCubit;
  late CardCubit cardCubit;

  late AllCampaignsCubit allCampaignsCubit;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _pageController2 = PageController(initialPage: _currentPage2);
    allCampaignsCubit = context.read<AllCampaignsCubit>();
    volunteerCubit = context.read<VolunteerCubit>();
    volunteerCubit.getJoinedVolunteerOpportunities();
    allCampaignsCubit.getAllCampaigns();
    cardCubit =context.read<CardCubit>();
    cardCubit.GetCurrentJoinedCampaignsAndOpp();
  }

  int selectedActivityType = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 170),
          child: Stack(
            children: [
              Image.asset(AppAssets.unionGreyImg),
              if (widget.hasBackButton == true)
                Positioned(
                  top: 35,
                  right: 6,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 40.w,
                        height: 40.h,
                        child: Transform.scale(
                            scale: 0.45,
                            child: SvgPicture.asset(
                              AppAssets.popUpIcon,
                            ))),
                  ),
                ),
              const Positioned.fill(
                top: 50,
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'الملف الشخصي',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Alexandria'),
                    )),
              ),
              Positioned(
                top: 70,
                right: 25,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 400),
                                child: EditAccountScreen()));
                      },
                      splashColor: Colors.transparent,
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: PreferencesHelper.getUserModel?.user?.photo !=
                                  null
                              ? Image.network(
                                  '${PreferencesHelper.getUserModel?.user?.photo}',
                            fit: BoxFit.fill,
                            width: 70,
                            height: 70,

                                )
                              : SvgPicture.asset(AppAssets.circleAvatar2,  fit: BoxFit.fill,
                            width: 70,
                            height: 70,),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PreferencesHelper.getIsVisitor
                              ? 'زائر'
                              : '${PreferencesHelper.getName}',
                          style: TextStyle(
                              fontFamily: 'Alexandria',
                              fontWeight: FontWeight.w500,
                              fontSize: 11),
                        ),
                        if (!PreferencesHelper.getIsVisitor)
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        child: EditAccountScreen()));
                              },
                              child: Text(
                                'تعديل الحساب',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffBDBDBD),
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Alexandria',
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(height: 10.h),
                        Row(
                          children: [
                            LinearPercentIndicator(
                              width: 190,
                              backgroundColor: const Color(0xffF1F1F1),
                              progressColor: const Color(0xffF7936F),
                              percent: 0,
                              isRTL: true,
                              lineHeight: 8,
                              padding: EdgeInsets.zero,
                              barRadius: const Radius.circular(5),
                            ),
                            SizedBox(width: 10),
                            // Image.asset(AppAssets.crownPng),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 90,
                left: 20,
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
                      'AppAssets.qrCode',
                    )),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: BlocBuilder<CardCubit, CardStates>(
              builder: (context, state) {
                return Stack(
                  children: [
                    Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25,right: 25, top: 15,bottom: 13),
                      child: Text(
                        'الأنشطة',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Alexandria',
                        ),
                      ),
                    ),
                    if(state is CardLoading)...[
                      Container(
                        width: 50,
                        height: 50,
                        child: Transform.scale(
                          scale: 0.6,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    if(state is CardSuccess)...[
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 7.w),
                        child: Container(
                          height: 52.h,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection:Axis.horizontal ,
                            reverse: true,
                            itemCount: cardCubit.currentJoinedCampaignsAndOpp?.currentVolunteerOpportunities?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                splashColor: Colors.transparent,
                                onTap: (){
                                  Navigator.push(context, PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: const Duration(milliseconds: 600),
                                      child:  VolunteerCardDetails(index: index)));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: VolunteerContainer(itemName: "${cardCubit.currentJoinedCampaignsAndOpp?.currentVolunteerOpportunities![index].name}"),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: state is CardSuccess && cardCubit.currentJoinedCampaignsAndOpp?.currentVolunteerOpportunities?.length==0?5.h:20.h,),
                    StatefulBuilder(builder: (context, setState) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: selectedActivityType == 0
                                            ? AppColors.orangeBorderColor
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(2)),
                                        minimumSize: const Size.fromHeight(40),
                                      ),
                                      onPressed: () {
                                        selectedActivityType = 0;
                                        setState(() {});
                                      },
                                      child: Text(
                                        'الحملات',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: selectedActivityType == 0
                                              ? Colors.white
                                              : const Color(0xFF878787),
                                          fontWeight: selectedActivityType == 0
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          fontFamily: 'Alexandria',
                                        ),
                                      ))),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2)),
                                    backgroundColor: selectedActivityType == 1
                                        ? AppColors.orangeBorderColor
                                        : Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedActivityType = 1;
                                    });
                                  },
                                  child: Text(
                                    'فرصة تطوعية',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: selectedActivityType == 1
                                          ? Colors.white
                                          : const Color(0xFF878787),
                                      fontWeight: selectedActivityType == 1
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      fontFamily: 'Alexandria',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 7.h),
                          if (selectedActivityType == 0) tabBar,
                          if (selectedActivityType == 1) tabBar2,
                          if (selectedActivityType == 1) pages2,
                          if (selectedActivityType == 0) pages,
                        ],
                      );
                    }),
                    SizedBox(
                      height: 11.h
                    ),
              ],
            ),
                    if(state is CardSuccess && cardCubit.currentJoinedCampaignsAndOpp?.currentVolunteerOpportunities?.length==0)...[
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Padding(
                          padding:  EdgeInsets.only(top: 53.h),
                          child: Text(
                            'لا توجد أنشطة حالية',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: FontFamilies.alexandria,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
  },
),
          ),
        ),
      ),
    );
  }

  void _changePage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
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
  get previousText => InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          _changePage(0);
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 2, bottom: 12, right: 2),
          child: Center(
            child: Text(
              AppStrings.past,
              style: TextStyle(
                  color: _currentPage == 0
                      ? AppColors.orangeBorderColor
                      : AppColors.greyTabColor,
                  fontFamily: FontFamilies.alexandria,
                  fontWeight:
                      _currentPage == 0 ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 11.5),
            ),
          ),
        ),
      );
  get currentText => InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          _changePage(1);
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 12, bottom: 12, right: 17),
          child: Text(
            AppStrings.current,
            style: TextStyle(
                color: _currentPage == 1
                    ? AppColors.greenTextColor
                    : AppColors.greyTabColor,
                fontFamily: FontFamilies.alexandria,
                fontWeight:
                    _currentPage == 1 ? FontWeight.w600 : FontWeight.w400,
                fontSize: 11.5),
          ),
        ),
      );
  get upcomingText => InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          _changePage(2);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            AppStrings.upcoming,
            style: TextStyle(
                color: _currentPage == 2
                    ? AppColors.blueTextColor
                    : AppColors.greyTabColor,
                fontFamily: FontFamilies.alexandria,
                fontWeight:
                    _currentPage == 2 ? FontWeight.w600 : FontWeight.w400,
                fontSize: 11.5),
          ),
        ),
      );
  get texts => Padding(
        padding: EdgeInsets.only(left: 12.w, right: 25.w, top: 2.h),
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
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  get tabBar2 => Stack(
        children: [
          divider2,
          tabs2,
          texts2,
        ],
      );
  get texts2 => Padding(
        padding: EdgeInsets.only(left: 12.w, right: 25.w, top: 2.h),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            previousText2,
            currentText2,
            upcomingText2,
          ],
        ),
      );
  get previousText2 => InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          _changePage2(0);
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 2, bottom: 12, right: 0),
          child: Text(
            'برامجك',
            style: TextStyle(
                color: _currentPage2 == 0
                    ? AppColors.blueTextColor
                    : AppColors.greyTabColor,
                fontFamily: FontFamilies.alexandria,
                fontWeight:
                    _currentPage2 == 0 ? FontWeight.w600 : FontWeight.w400,
                fontSize: 11.5),
          ),
        ),
      );
  get currentText2 => InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          _changePage2(1);
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 12, bottom: 12, right: 24),
          child: Text(
            'أنشطتك',
            style: TextStyle(
                color: _currentPage2 == 1
                    ? AppColors.blueTextColor
                    : AppColors.greyTabColor,
                fontFamily: FontFamilies.alexandria,
                fontWeight:
                    _currentPage2 == 1 ? FontWeight.w600 : FontWeight.w400,
                fontSize: 11.5),
          ),
        ),
      );
  get upcomingText2 => InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          _changePage2(2);
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 12, left: 10, bottom: 12, right: 17),
          child: Text(
            'مهامك',
            style: TextStyle(
                color: _currentPage2 == 2
                    ? AppColors.blueTextColor
                    : AppColors.greyTabColor,
                fontFamily: FontFamilies.alexandria,
                fontWeight:
                    _currentPage2 == 2 ? FontWeight.w600 : FontWeight.w400,
                fontSize: 11.5),
          ),
        ),
      );
  get divider2 => Padding(
        padding: EdgeInsets.only(top: 33.h),
        child: Divider(
          thickness: 1.w,
        ),
      );
  get tabs2 => Padding(
        padding: EdgeInsets.only(
          left: 13.w,
          right: 12.w,
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            previousContainer2,
            currentContainer2,
            upcomingContainer2,
          ],
        ),
      );
  get previousContainer2 => Container(
        width: 70.w,
        height: 43.h,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: _currentPage2 == 0 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            left: BorderSide(
                color: _currentPage2 == 0 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            right: BorderSide(
                color: _currentPage2 == 0 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            bottom: BorderSide(
                color: _currentPage2 == 0 ? Colors.white : Colors.transparent,
                width: 2.5.w),
          ),
        ),
      );
  get currentContainer2 => Container(
        width: 70.w,
        height: 43.h,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: _currentPage2 == 1 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            left: BorderSide(
                color: _currentPage2 == 1 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            right: BorderSide(
                color: _currentPage2 == 1 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            bottom: BorderSide(
                color: _currentPage2 == 1 ? Colors.white : Colors.transparent,
                width: 2.5.w),
          ),
        ),
      );
  get upcomingContainer2 => Container(
        width: 70.w,
        height: 43.h,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: _currentPage2 == 2 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            left: BorderSide(
                color: _currentPage2 == 2 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            right: BorderSide(
                color: _currentPage2 == 2 ? Colors.grey.shade300 : Colors.white,
                width: 1.w),
            bottom: BorderSide(
                color: _currentPage2 == 2 ? Colors.white : Colors.transparent,
                width: 2.5.w),
          ),
        ),
      );
  void _changePage2(int page) {
    _pageController2.animateToPage(
      page,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
  }

  get pages2 => SizedBox(
        height: 420,
        width: double.infinity,
        child: PageView(
          controller: _pageController2,
          onPageChanged: (int page) {
            setState(() {
              _currentPage2 = page;
            });
          },
          children: [
            JoinedProgramCard(),
            JoinedOneDayActivity(),
            JoinedRemoteTasks(),
          ],
        ),
      );
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  get pages => SizedBox(
        height: 420,
        child: PageView(
          //physics:const ClampingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            JoinedPreviousCampaigns(),
            JoinedCurrentCampaigns(),
            JoinedUpcomingCampaigns(),
          ],
        ),
      );
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
  get dropDownIcon => GestureDetector(
        onTap: () {},
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
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(top: 64.h),
          child: Image.asset(AppAssets.crownPng),
        ),
      );
  get name => Padding(
        padding: EdgeInsets.only(left: 127.w, top: 20.h),
        child: const Text(
          AppStrings.lailaAhmed,
          style: TextStyle(
              color: Colors.white,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w500,
              fontSize: 13),
        ),
      );
  get progressLine => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          width: 200.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(15.r), // Adjust the radius as needed
          ),
          child: Padding(
            padding: EdgeInsets.only(
                right: 2.7.w, top: 2.7.h, bottom: 2.7.w, left: 113.w),
            child: Container(
              width: 60.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius:
                    BorderRadius.circular(15.r), // Adjust the radius as needed
              ),
            ),
          ),
        ),
      );
  get nameAndProgress => Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          name,
          SizedBox(
            height: 20.h,
          ),
          progressLine,
        ],
      );
  get circleAvatar => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Padding(
          padding: EdgeInsets.only(top: 19.h),
          child: CircleAvatar(
              radius: 40.r, backgroundColor: Colors.white, child: Text('M')),
        ),
      );
  get details => Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(width: 11.w),
          circleAvatar,
          SizedBox(
            width: 10.w,
          ),
          nameAndProgress,
          SizedBox(width: 13.w),
          crownIcon,
          SizedBox(width: 11.w),
          dropDownIcon,
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
            width: 20.w,
          ),
          arrowIcon,
          SizedBox(
            width: 5.w,
          ),
          moreText,
          SizedBox(
            width: 240.w,
          ),
          activitiesText,
        ],
      );
  get upcomingText3 => Align(
        alignment: AlignmentDirectional.topEnd,
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
        alignment: AlignmentDirectional.centerStart,
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
            width: 1.5, // Adjust the border width as needed
          ),
        ),
        child: Column(
          children: [
            upcomingText3,
            educationText,
          ],
        ),
      );
  get currentText4 => Align(
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
        alignment: AlignmentDirectional.centerStart,
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
  get currentPalestineCard => Container(
        width: 117.w,
        height: 49.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.r),
          color: Colors.white70,
          border: Border.all(
            color: AppColors.greenBorderColor,
            width: 1.5, // Adjust the border width as needed
          ),
        ),
        child: Stack(
          children: [
            currentText3,
            palestineText,
          ],
        ),
      );
  get currentText3 => Align(
        alignment: AlignmentDirectional.topEnd,
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
  get previousTex3 => Align(
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
        alignment: AlignmentDirectional.centerStart,
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
        alignment: AlignmentDirectional.centerStart,
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
            width: 1.5, // Adjust the border width as needed
          ),
        ),
        child: Column(
          children: [
            currentText3,
            orphanText,
          ],
        ),
      );
  get previousOrphanCard => Container(
        width: 117.w,
        height: 49.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.r),
          color: Colors.white70,
          border: Border.all(
            color: AppColors.orangeBorderColor,
            width: 1.5, // Adjust the border width as needed
          ),
        ),
        child: Column(
          children: [
            previousText2,
            previousOrphanText,
          ],
        ),
      );
  get cards => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SizedBox(
          height: 49.h,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            //reverse: true,
            children: [
              currentOrphanCard,
              SizedBox(
                width: 6.w,
              ),
              currentPalestineCard,
              SizedBox(
                width: 6.w,
              ),
              upcomingCard,
              SizedBox(
                width: 6.w,
              ),
              upcomingCard,
              SizedBox(
                width: 6.w,
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
      child: Column(
        children: [
          details,
          SizedBox(
            height: 20.h,
          ),
          activitiesAndMore,
          SizedBox(
            height: 17.h,
          ),
          cards,
        ],
      ));
  get newsText => Padding(
        padding: EdgeInsets.only(top: 13.h, right: 4.w),
        child: Text(
          AppStrings.news,
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
  get infoIcon => Padding(
        padding: EdgeInsets.only(right: 9.w, top: 23.h),
        child: SvgPicture.asset(
          AppAssets.urgentNewsIcon,
          width: 22.w,
          height: 22.h,
        ),
      );
  get newsCard => Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: SizedBox(
          height: 71.h,
          child: PageView.builder(
            reverse: true,
            controller: _pageController,
            itemCount: 3, // Adjust the number of items based on your ListView
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return newsSample;
            },
          ),
        ),
      );
  get textNews => Text(
        AppStrings.news2,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            height: 2.h,
            color: Colors.black,
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w400,
            fontSize: 11),
      );
  get dateCircleAvatar => Padding(
        padding: EdgeInsets.only(right: 13.5.w),
        child: CircleAvatar(
          backgroundColor: AppColors.darkBlueColor,
          radius: 35.r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              dateText,
              SizedBox(
                height: 3.h,
              ),
              yearText,
            ],
          ),
        ),
      );
  get newsContainer => Container(
        width: 430.w,
        height: 115.h,
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            textNews,
            SizedBox(
              width: 12.w,
            ),
            dateCircleAvatar,
          ],
        ),
      );
  get newsList => Expanded(
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  newsContainer,
                  SizedBox(
                    height: 8.h,
                  ),
                ],
              );
            }),
      );
  get newsSample => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 400),
                  child: NewsDetails()));
        },
        child: Container(
          margin: EdgeInsets.only(left: 4.w, right: 4.w),
          width: 383.w,
          height: 71.h,
          decoration: BoxDecoration(
            color: AppColors.redColor,
            borderRadius: BorderRadius.circular(7.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              newsText,
              SizedBox(
                width: 5.w,
              ),
              infoIcon,
            ],
          ),
        ),
      );
  get dotsIndicator => Directionality(
        textDirection: TextDirection.rtl,
        child: DotsIndicator(
          dotsCount: 3,
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
  get dateText => const Text(
        AppStrings.october15,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilies.alexandria),
      );
  get yearText => const Text(
        AppStrings.year2023,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamilies.alexandria),
      );
  get logoImg => Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
          padding: EdgeInsets.only(left: 9.w, bottom: 6.h),
          child: SvgPicture.asset(
            AppAssets.blueLifeMakersLogo,
          )));
  get dotsIcon => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: EdgeInsets.only(left: 13.w),
        child: SvgPicture.asset(
          AppAssets.dotsIcon,
          height: 13.h,
        ),
      ));
  get calendarIcon => SvgPicture.asset(
        AppAssets.calendarIcon,
        width: 12.w,
      );
// get dateText => Padding(
//   padding:  EdgeInsets.only(top: 2.h),
//   child: const Text(
//     AppStrings.date,
//     style: TextStyle(
//         color: Colors.grey,
//         fontFamily: FontFamilies.alexandria,
//         fontWeight: FontWeight.w400,
//         fontSize: 9.5
//     ),
//   ),
// );
// get previousText2 => Align(
//   alignment: AlignmentDirectional.topEnd,
//   child: Padding(
//     padding: EdgeInsets.only(left: 8.w, top: 4.h),
//     child: const Text(
//       AppStrings.past,
//       style: TextStyle(
//           fontFamily: FontFamilies.alexandria,
//           fontWeight: FontWeight.w700,
//           color: AppColors.orangeBorderColor,
//           fontSize: 7),
//     ),
//   ),
// );
}
