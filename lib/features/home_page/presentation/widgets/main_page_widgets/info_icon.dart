import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';

class HomeInfoIcon extends StatelessWidget {
  const HomeInfoIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 9.w, top: 23.h),
      child: SvgPicture.asset(
        AppAssets.urgentNewsIcon,
        width: 22.w,
        height: 22.h,
      ),
    );
  }
}
