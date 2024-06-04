import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:life_makers/core/utils/app-assets.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final drawer = ZoomDrawer.of(context);
        if (drawer != null) {
          if (drawer.isOpen()) {
            drawer.close();
          } else {
            drawer.open();
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16.w),
        child: SvgPicture.asset(
          AppAssets.menuIcon,
        ),
      ),
    );
  }
}
