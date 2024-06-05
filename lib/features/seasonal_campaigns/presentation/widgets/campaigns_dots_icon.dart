import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';

class CampaignDotsIcon extends StatelessWidget {
  const CampaignDotsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.only(left: 13.w),
          child: SvgPicture.asset(
            AppAssets.dotsIcon,
            height: 13.h,
          ),
        ));
  }
}
