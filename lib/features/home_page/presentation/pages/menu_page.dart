import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/authentication/presentation/pages/login_screen.dart';
import 'package:life_makers/features/elections/presentation/pages/terms_page.dart';
import 'package:life_makers/features/home_page/domain/menu_page_cubit/menu_page_cubit.dart';
import 'package:life_makers/features/membership_controll/screens/membership_control_screen.dart';
import 'package:life_makers/features/home_page/presentation/pages/profile_screen.dart';
import 'package:life_makers/features/non_seasonal_campaigns/presentation/pages/non_seasonal_campaigns.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/volunteer_opportunity_screen.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../edit_account/screens/edit_account_screen.dart';
import '../../../elections/presentation/pages/before_elections_screen.dart';
import '../../../seasonal_campaigns/presentation/pages/seasonal_campaigns.dart';
import '../../domain/menu_page_cubit/menu_page_states.dart';
import '../widgets/drawer_text.dart';

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
            backgroundColor: AppColors.drawerColor,
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: _refresh,
                color: Colors.white,
                backgroundColor: AppColors.orangeBorderColor,
                child: SingleChildScrollView(
                  physics:const  AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      closeDrawerIcon,
                      if(!PreferencesHelper.getIsVisitor)...[
                        SizedBox(
                        height: 20.h,
                      ),
                      ],
                      if(!PreferencesHelper.getIsVisitor)...[
                        mentorshipEdit,
                      ],
                      SizedBox(
                        height: 20.h,
                      ),
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
                                padding: EdgeInsets.symmetric(vertical: 22.h),
                                child: const DrawerText(
                                    text:
                                    AppStrings.volunteerBoardOfDirectorsElections,
                                    img: AppAssets
                                        .volunteerBoardOfDirectorsElectionsIcon,
                                    font: 11),
                              )),
                      SizedBox(height:menuCubit.isVisible==false? 145.h:80.h),
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  AppStrings.signOut,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: FontFamilies.alexandria,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 11.w,
                                ),
                                SvgPicture.asset(AppAssets.signOutIcon),
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

  get closeDrawerIcon => InkWell(
    splashColor: Colors.transparent,
        onTap: () {
          ZoomDrawer.of(context)!.close();
        },
        child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: EdgeInsets.all(26.w),
              child: SvgPicture.asset(AppAssets.closeDrawerICon),
            )),
      );
  get mentorshipText => Text(
        AppStrings.membershipControl,
        style: TextStyle(
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
            fontSize: 12.5),
      );
  get settingsIcon => SvgPicture.asset(AppAssets.settingsIcon);
  get mentorshipEdit => InkWell(
    splashColor: Colors.transparent,
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 400),
                  child: const MembershipControl()));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 68),
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              width: 160.w,
              height: 47.h,
              decoration: BoxDecoration(
                  color: AppColors.greyContainerColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.r),
                    bottomLeft: Radius.circular(6.r),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  mentorshipText,
                  SizedBox(width: 11.w),
                  settingsIcon,
                ],
              ),
            ),
          ),
        ),
      );
}
