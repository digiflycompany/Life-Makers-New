import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:life_makers/core/utils/app-assets.dart';

class CloseDrawerIcon extends StatelessWidget {
  const CloseDrawerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          ZoomDrawer.of(context)!.close();
        },
        child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsets.all(26.w),
              child: SvgPicture.asset(AppAssets.closeDrawerICon),
            )),
      ),
    );
  }
}
