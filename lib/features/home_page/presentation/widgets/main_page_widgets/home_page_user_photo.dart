import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class HomePageUserPhoto extends StatelessWidget {
  const HomePageUserPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: AlignmentDirectional.topEnd,
      child: Padding(
        padding: EdgeInsets.only(top: 19.h,right: 11.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.r),
          child: Container(
              height: 65.h,
              width: 70.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)),
              child: PreferencesHelper.getUserModel?.user?.photo == null
                  ? SvgPicture.asset(
                AppAssets.circleAvatar2,
                fit: BoxFit.fill,
                width: 70.w,
                height: 65.h,
              )
                  : Image.network(
                  width: 70.w,
                  height: 65.h,
                  fit: BoxFit.fill,
                  PreferencesHelper.getUserModel!.user!.photo!)),
        ),
      ),
    );
  }
}
