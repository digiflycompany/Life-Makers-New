import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/home_page/presentation/pages/profile_screen.dart';
import 'package:life_makers/features/notification/presentation/pages/notification_page.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const MainPage(),
    const NotificationPage(),
    const ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor3,
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        height: 70.h,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? SvgPicture.asset(AppAssets.homeSelectedIcon)
                  : SvgPicture.asset(AppAssets.homeUnselectedIcon),
              label: AppStrings.mainPage,
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1
                  ? SvgPicture.asset(AppAssets.notificationSelectedIcon)
                  : SvgPicture.asset(AppAssets.notificationUnselectedIcon),
              label: AppStrings.notifications,
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2
                  ? SvgPicture.asset(AppAssets.profileSelectedIcon)
                  : SvgPicture.asset(AppAssets.profileUnselectedIcon),
              label: AppStrings.personalFile,
            ),
          ],
          selectedItemColor: AppColors.blueColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: FontFamilies.alexandria,
              fontSize: 12.sp,
              height: 2.h
          ),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: FontFamilies.alexandria,
              fontSize: 12.sp,
              height: 2.h
          ),
        ),
      ),
    );
  }
}
