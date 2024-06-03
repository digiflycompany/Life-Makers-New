import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class LogoutIcon extends StatelessWidget {
  const LogoutIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: ()=>PreferencesHelper.logOut(),
      child: Padding(
        padding: EdgeInsets.only(top: 22.h,bottom: 22.h,right: 15.7.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(AppAssets.signOutIcon),
            SizedBox(
              width: 11.w,
            ),
            Text(
              AppStrings.signOut,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamilies.alexandria,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
