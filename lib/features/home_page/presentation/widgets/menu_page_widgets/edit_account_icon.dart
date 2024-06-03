import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/home_page/presentation/widgets/drawer_text.dart';

class EditAccountIcon extends StatelessWidget {
  const EditAccountIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        onTap: ()=> Routes.editAccountPageRoute.moveTo,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 22.h),
          child: DrawerText(
              text: AppStrings.editProfile,
              img: AppAssets.editProfileIcon,
              font: 11.5.sp),
        ));
  }
}
