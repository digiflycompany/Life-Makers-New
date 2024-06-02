import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

class CustomBanners extends StatelessWidget {
  const CustomBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(AppAssets.lifeMakerBanner),
        Column(
          children: [
             Text(
              AppStrings.lifeMakers,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamilies.alexandria,
                  fontWeight: FontWeight.w700,
                  fontSize: 10.sp),
            ),
            SizedBox(
              height: 5.h,
            ),
             Text(
              AppStrings.becomeVolunteer,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamilies.alexandria,
                  fontWeight: FontWeight.w400,
                  fontSize: 8.sp),
            ),
          ],
        ),
      ],
    );
  }
}
