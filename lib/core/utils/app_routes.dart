import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/authentication/presentation/pages/enter_phone_screen.dart';
import 'package:life_makers/features/authentication/presentation/pages/login_screen.dart';
import 'package:life_makers/features/authentication/presentation/pages/otp_screen.dart';
import 'package:life_makers/features/authentication/presentation/pages/sign_up_screen.dart';
import 'package:life_makers/features/home_page/presentation/pages/drawer_page.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

enum PageRouteAnimation { fade, scale, rotate, slide, slideBottomTop }

class Routes {
  Routes._internal();

  static const String firstPageRoute = "/";
  static const String loginPageRoute = "/login_screen";
  static const String signUpPageRoute = "/sign_up_screen";
  static const String otpPageRoute = "/otp_screen";
  static const String enterPhonePageRoute = "/enter_phone_screen";
  static const String changPasswordPageRoute = "/change_password";
  static const String mainPageRoute = "/drawer_page";
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
