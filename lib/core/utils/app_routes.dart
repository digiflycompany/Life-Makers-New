import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/volunteer_card_details.dart';
import 'package:life_makers/features/authentication/presentation/pages/change_password.dart';
import 'package:life_makers/features/authentication/presentation/pages/enter_phone_screen.dart';
import 'package:life_makers/features/authentication/presentation/pages/login_screen.dart';
import 'package:life_makers/features/authentication/presentation/pages/otp_screen.dart';
import 'package:life_makers/features/authentication/presentation/pages/sign_up_screen.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/campaign_details_screen.dart';
import 'package:life_makers/features/edit_account/screens/edit_account_screen.dart';
import 'package:life_makers/features/elections/presentation/pages/before_elections_screen.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';
import 'package:life_makers/features/home_page/presentation/pages/drawer_page.dart';
import 'package:life_makers/features/home_page/presentation/pages/home_calender_details_screen.dart';
import 'package:life_makers/features/home_page/presentation/pages/profile_screen.dart';
import 'package:life_makers/features/membership_controll/screens/membership_control_screen.dart';
import 'package:life_makers/features/non_seasonal_campaigns/presentation/pages/non_seasonal_campaigns.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/pages/seasonal_campaigns.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/volunteer_opportunity_screen.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

enum PageRouteAnimation { fade, scale, rotate, slide, slideBottomTop }

class Routes {
  Routes._internal();
  static const String firstPageRoute = "/";
  static const String loginPageRoute = "/login_screen";
  static const String signUpPageRoute = "/sign_up_screen";
  static const String otpPageRoute = "/otp_screen";
  static const String enterPhonePageRoute = "/enter_phone_screen";
  static const String changePasswordPageRoute = "/change_password";
  static const String mainPageRoute = "/drawer_page";
  static const String profilePageBackIconRoute = "/profile_screen";
  static const String volunteerCardDetailsPageRoute = "/volunteer_card_details";
  static const String membershipControlPageRoute = "/membership_control_screen";
  static const String profilePageRoute = "/profile_screen";
  static const String editAccountPageRoute = "/edit_account_screen";
  static const String seasonalCampaignsPageRoute = "/seasonal_campaigns";
  static const String nonSeasonalCampaignsPageRoute = "/non_seasonal_campaigns";
  static const String homeCalenderDetailsPageRoute = "/home_calender_details_screen";
  static const String campaignDetailsPageRoute = "/campaign_details_screen";
  static const String volunteerOpportunityPageRoute =
      "/volunteer_opportunity_screen";
  static const String beforeElectionsPageRoute = "/before_elections_screen";
}

class RouteGenerator {
  RouteGenerator._internal();

  PageRouteAnimation? pageRouteAnimationGlobal;
  static Duration pageRouteTransitionDurationGlobal = 200.milliseconds;

  static Route<dynamic>? getRoute(RouteSettings routeSettings) {
    debugPrint(routeSettings.name);
    switch (routeSettings.name) {
      case Routes.firstPageRoute:
        return buildPageRoute(
            child: PreferencesHelper.applicationFirstPage,
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.loginPageRoute:
        return buildPageRoute(
            child: const LoginScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.signUpPageRoute:
        return buildPageRoute(
            child: SignUpScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.enterPhonePageRoute:
        return buildPageRoute(
            child: EnterPhoneScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.mainPageRoute:
        return buildPageRoute(
            child: DrawerPage(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.otpPageRoute:
        return buildPageRoute(
            child: OtpScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.beforeElectionsPageRoute:
        return buildPageRoute(
            child: BeforeElectionsScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.membershipControlPageRoute:
        return buildPageRoute(
            child: MembershipControl(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.profilePageRoute:
        return buildPageRoute(
            child: ProfileScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.seasonalCampaignsPageRoute:
        return buildPageRoute(
            child: SeasonalCampaignsScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.volunteerOpportunityPageRoute:
        return buildPageRoute(
            child: VolunteerOpportunityScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.nonSeasonalCampaignsPageRoute:
        return buildPageRoute(
            child: NonSeasonalCampaignsScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.editAccountPageRoute:
        return buildPageRoute(
            child: EditAccountScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.changePasswordPageRoute:
        return buildPageRoute(
            child: ChangePasswordScreen(),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.homeCalenderDetailsPageRoute:
        final calendar = routeSettings.arguments as Calender;
        return buildPageRoute(
            child: HomeCalenderDetailsScreen(calender: calendar),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.campaignDetailsPageRoute:
        final args = routeSettings.arguments as Map<String, dynamic>;
        final campaignDetails = args['campaignDetails'] as Campaigns?;
        return buildPageRoute(
          child: CampaignDetailsScreen(campaignDetails: campaignDetails),
          routeSettings: routeSettings,
          pageRouteAnimation: PageRouteAnimation.fade,
        );
      case Routes.volunteerCardDetailsPageRoute:
        final index = routeSettings.arguments as int;
        return buildPageRoute(
            child: VolunteerCardDetails(index: index),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
      case Routes.profilePageBackIconRoute:
        final hasBackButton = routeSettings.arguments as bool;
        return buildPageRoute(
            child: ProfileScreen(
              hasBackButton: hasBackButton,
            ),
            routeSettings: routeSettings,
            pageRouteAnimation: PageRouteAnimation.fade);
    }
    return buildPageRoute(
        child: const Center(
          child: Text("no route found"),
        ),
        routeSettings: routeSettings);
  }

  static Route<T> buildPageRoute<T>({
    required Widget child,
    PageRouteAnimation? pageRouteAnimation,
    Duration? duration,
    RouteSettings? routeSettings,
  }) {
    if (pageRouteAnimation != null) {
      if (pageRouteAnimation == PageRouteAnimation.fade) {
        return PageRouteBuilder(
          settings: routeSettings,
          transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
          reverseTransitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return FadeTransition(opacity: anim, child: child);
          },
        );
      } else if (pageRouteAnimation == PageRouteAnimation.rotate) {
        return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return RotationTransition(
                turns: ReverseAnimation(anim), child: child);
          },
          transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
        );
      } else if (pageRouteAnimation == PageRouteAnimation.scale) {
        return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return ScaleTransition(scale: anim, child: child);
          },
          transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
        );
      } else if (pageRouteAnimation == PageRouteAnimation.slide) {
        return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1.0, 0.0),
                end: const Offset(0.0, 0.0),
              ).animate(anim),
              child: child,
            );
          },
          transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
        );
      } else if (pageRouteAnimation == PageRouteAnimation.slideBottomTop) {
        return PageRouteBuilder(
          settings: routeSettings,
          pageBuilder: (c, a1, a2) => child,
          transitionsBuilder: (c, anim, a2, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0.0, 1.0),
                end: const Offset(0.0, 0.0),
              ).animate(anim),
              child: child,
            );
          },
          transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
        );
      }
    } else {
      return PageRouteBuilder(
        settings: routeSettings,
        transitionDuration: duration ?? pageRouteTransitionDurationGlobal,
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (c, a1, a2) => child,
        transitionsBuilder: (c, anim, a2, child) {
          return FadeTransition(opacity: anim, child: child);
        },
      );
    }
    return MaterialPageRoute<T>(
      builder: (_) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          child: child),
      settings: routeSettings,
    );
  }
}
