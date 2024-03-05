import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/home_page/presentation/pages/profile_screen.dart';
import 'package:life_makers/features/notification/presentation/pages/notification_page.dart';
import '../../../../core/utils/app-color.dart';
import '../../data/models/nav_bar_model.dart';
import '../widgets/custom_paint.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int selectBtn = navBtn2.length - 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectBtn);
    // if (Platform.isAndroid) FirebaseCustomNotification.setUpFirebase();
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          pages,
          navBar,
        ],
      ),
    );
  }

  get pages => PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectBtn = index;
          });
        },
        children: const [
          ProfileScreen(),
          NotificationPage(),
          MainPage(),
        ],
      );
  get navBar => Align(
        alignment: Alignment.bottomCenter,
        child: navigationBar(),
      );
  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 87.0.h,
      duration: const Duration(milliseconds: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 20.0),
          topRight:
              Radius.circular(selectBtn == navBtn2.length - 1 ? 0.0 : 20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn2.length; i++)
            GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 70.0.h : 0.0;
    var width = isActive ? 80.0.w : 0.0;
    return SizedBox(
      width: 137.0.w,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 20),
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotch(),
                    )
                  : const SizedBox(),
            ),
          ),
          if (isActive)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: navBtn[i] == navBtn[0]
                    ? EdgeInsets.only(top: 20.h, left: 9.6.w)
                    : EdgeInsets.only(top: 20.h, left: 24.w),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 7.h),
                      child: Text(
                        isActive ? navBtn[i].name : '',
                        style: const TextStyle(
                            fontFamily: FontFamilies.alexandria,
                            color: AppColors.navBarTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SvgPicture.asset(
                      navBtn[i].imagePath,
                      height: 25.h,
                      width: 25.w,
                      //color: isActive ? AppColors.selectColor : AppColors.black,
                      //scale: 0.85,
                    ),
                  ],
                ),
              ),
            ),
          if (isActive == false)
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, left: 10.w),
                child: SvgPicture.asset(
                  navBtn2[i].imagePath,
                  height: 25.h,
                  width: 25.w,
                  //color: isActive ? AppColors.selectColor : AppColors.black,
                  //scale: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
