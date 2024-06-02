import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/utils/app-color.dart';
import 'home_page.dart';
import 'menu_page.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({super.key});

  final ZoomDrawerController _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      style: DrawerStyle.defaultStyle,
      menuScreen: const MenuScreen(),
      mainScreenTapClose: true,
      mainScreen: HomePage(),
      borderRadius: 24.r,
      shadowLayer1Color: AppColors.blueColor,
      showShadow: true,
      angle: 0.0,
      drawerShadowsBackgroundColor: Colors.grey.shade400,
      slideWidth: MediaQuery.of(context).size.width * 0.72,
      isRtl: true,
    );
  }
}
