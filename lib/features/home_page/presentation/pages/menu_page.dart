import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/authentication/presentation/pages/login_screen.dart';
import 'package:life_makers/features/edit_account/screens/edit_account_screen.dart';
import 'package:life_makers/features/elections/presentation/pages/before_elections_screen.dart';
import 'package:life_makers/features/elections/presentation/pages/terms_page.dart';
import 'package:life_makers/features/home_page/cubit/menu_page_cubit/menu_page_cubit.dart';
import 'package:life_makers/features/home_page/cubit/menu_page_cubit/menu_page_states.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/presentation/pages/seasonal_campaigns.dart';
import 'package:life_makers/features/home_page/presentation/widgets/drawer_text.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/close_drawer_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/mentorship_edit_icon.dart';
import 'package:life_makers/features/home_page/presentation/pages/profile_screen.dart';
import 'package:life_makers/features/non_seasonal_campaigns/presentation/pages/non_seasonal_campaigns.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/volunteer_opportunity_screen.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final DateTime apiStartDate;
  late final DateTime apiEndDate;
  DateTime? startTime;
  DateTime? endTime;

  late MenuCubit menuCubit;
  @override
  void initState() {
    super.initState();
    menuCubit = context.read<MenuCubit>();
    menuCubit.fetchDateAndTime().then((value) {
      String? apiStartDateString = menuCubit.appSettingsModel?.data?.electionsStartDate;
      String? apiEndDateString = menuCubit.appSettingsModel?.data?.electionsEndDate;
      if (kDebugMode) {
        print(apiEndDateString);
        print('***** DATE *****');
        print(apiEndDateString);
      }
      if(apiStartDateString!=null && apiEndDateString!=null)
      {
        startTime= DateTime.parse(apiStartDateString);
        endTime= DateTime.parse(apiEndDateString);
      }
    });
     if (kDebugMode) {
       print('$startTime');
       print('$endTime');

     }
  }
  @override
  void dispose() {
    startTime =DateTime.now();
    endTime =DateTime.now();
    super.dispose();
  }
  Future<void> _refresh() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await  menuCubit.fetchDateAndTime().then((value) {
        String? apiStartDateString = menuCubit.appSettingsModel?.data?.electionsStartDate;
        String? apiEndDateString = menuCubit.appSettingsModel?.data?.electionsEndDate;

        if (kDebugMode) {
          print('***** DATE *****');
          print(apiEndDateString);
          print(apiEndDateString);
        }

        if(apiStartDateString!=null && apiEndDateString!=null)
        {
          startTime= DateTime.parse(apiStartDateString);
          endTime= DateTime.parse(apiEndDateString);
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error refreshing data: $error');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          PreferencesHelper.logOut();
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 300),
                  child: LoginScreen()),
              (value) => true);
        } else if (state is DeleteAccountFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            duration: Duration(seconds: 2),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.blueColor,
            body: SafeArea(
              child: RefreshIndicator.adaptive(
                onRefresh: _refresh,
                color: Colors.white,
                backgroundColor: AppColors.orangeColor,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const CloseDrawerIcon(),
                      if(!PreferencesHelper.getIsVisitor)...[
                         VerticalSpace(20.h),
                      ],
                      if(!PreferencesHelper.getIsVisitor)...[
                        const MentorShipEditIcon(),
                      ],
                       VerticalSpace(20.h),
                      if(!PreferencesHelper.getIsVisitor)...[
                        InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 280),
                                  child: const ProfileScreen(hasBackButton: true),
                                ),
                              );
                            },
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 22.h),
                              child: const DrawerText(
                                text: AppStrings.personalFile,
                                img: AppAssets.profileWhiteIcon2,
                                font: 11.5,
                              ),
                            )),
                        InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: const Duration(milliseconds: 280),
                                      child: const EditAccountScreen()));
                            },
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 22.h),
                              child: const DrawerText(
                                  text: AppStrings.editProfile,
                                  img: AppAssets.editProfileIcon,
                                  font: 11.5),
                            )),
                      ],
                      Padding(
                        padding: EdgeInsets.only(right: 15.7.w),
                        child: Column(
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: (){
                                menuCubit.toggleCampaigns();
                              },
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 22.h),
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(AppAssets.campaignsIcon),
                                    SizedBox(
                                      width: 11.w,
                                    ),
                                    const Text(
                                      AppStrings.campaigns,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontFamilies.alexandria,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    menuCubit.isVisible == false
                                        ? InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: (){
                                        menuCubit.toggleCampaigns();
                                      },
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 2.h),
                                              child: SvgPicture.asset(
                                                  AppAssets.dropDownWhiteIcon),
                                            ),
                                          )
                                        : InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: (){
                                        menuCubit.toggleCampaigns();
                                      },
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 2.h),
                                              child: SvgPicture.asset(
                                                  AppAssets.upArrowIcon),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            menuCubit.isVisible == true
                                ? SizedBox(
                                    height: 0.h,
                                  )
                                : SizedBox(
                                    height: 0.h,
                                  ),
                            if (menuCubit.isVisible == true)
                              Padding(
                                padding: EdgeInsets.only(right: 43.w,),
                                child: Column(
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                duration: const Duration(
                                                    milliseconds: 280),
                                                child:
                                                    const SeasonalCampaignsScreen()));
                                      },
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 14.h),
                                            child: SvgPicture.asset(
                                                AppAssets.whitePoint),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          const Text(
                                            AppStrings.seasonalCampaigns,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    FontFamilies.alexandria,
                                                fontSize: 11.5,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                duration: const Duration(
                                                    milliseconds: 280),
                                                child:
                                                    const NonSeasonalCampaignsScreen()));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 14.h),
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 3.h),
                                              child: SvgPicture.asset(
                                                  AppAssets.whitePoint),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            const Text(
                                              AppStrings.noSeasonalCampaigns,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontFamilies.alexandria,
                                                  fontSize: 11.5,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                      InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 280),
                                    child: const VolunteerOpportunityScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 22.h),
                            child: const DrawerText(
                                text: AppStrings.volunteerOpportunities,
                                img: AppAssets.volunteerIcon,
                                font: 11.5),
                          )),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 280),
                                  child: const BeforeElectionsScreen()));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 22.h),
                          child: const DrawerText(
                              text:
                              AppStrings.volunteerBoardOfDirectorsElections2,
                              img: AppAssets
                                  .volunteerBoardOfDirectorsElectionsIcon,
                              font: 11),
                        ),
                      ),
                          if(!PreferencesHelper.getIsVisitor)
                          InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                if( DateTime.now().isAfter(startTime!) && DateTime.now().isBefore(endTime!))
                                {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          duration: const Duration(milliseconds: 280),
                                          child: const TermsPage()));
                                } else{
                                  //todo

                                  CustomSnackBars.showRegularToast(title: 'ستبدأ إنتخابات مجلس المتطوعين قريبًا');
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 22.h),
                                child: const DrawerText(
                                    text:
                                    AppStrings.volunteerBoardOfDirectorsElections,
                                    img: AppAssets
                                        .volunteerBoardOfDirectorsElectionsIcon,
                                    font: 11),
                              )),
                      SizedBox(height:menuCubit.isVisible==false? 30.h:20.h),
                      if (!PreferencesHelper.getIsVisitor)
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: ()   {
                              PreferencesHelper.logOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 100),
                                    child: LoginScreen()),
                                    (vale) => true);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 22.h,bottom: 22.h,right: 15.7.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(AppAssets.signOutIcon),
                                SizedBox(
                                  width: 11.w,
                                ),
                                const Text(
                                  AppStrings.signOut,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: FontFamilies.alexandria,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: const Duration(milliseconds: 400),
                                  child: LoginScreen(),
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 15.7.w,bottom: 22.h,top: 22.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'تسجيل الدخول',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: FontFamilies.alexandria,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 11.w,
                                ),
                                Icon(Icons.login,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: 50.h,),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
