import 'package:flutter/material.dart';
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
      //duration: ,
      style: DrawerStyle.defaultStyle,
      menuScreen: const MenuScreen(),
      mainScreen:  HomePage(),
      borderRadius: 24.0,
      shadowLayer1Color: AppColors.drawerColor,
      showShadow: true,
      angle: 0.0,
      drawerShadowsBackgroundColor: Colors.grey.shade400,
      slideWidth: MediaQuery.of(context).size.width * 0.72,
      isRtl: true,
    );
  }
}
