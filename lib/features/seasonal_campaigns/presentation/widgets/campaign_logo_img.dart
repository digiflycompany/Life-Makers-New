import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';

class CampaignLogoImg extends StatelessWidget {
  const CampaignLogoImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Padding(
          padding: EdgeInsets.only(left: 9.w, bottom: 6.h),
          child: SvgPicture.asset(AppAssets.orangeLifeMakerLogo),
        ));
  }
}
