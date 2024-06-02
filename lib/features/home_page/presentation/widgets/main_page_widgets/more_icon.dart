import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';

class MoreIcon extends StatelessWidget {
  const MoreIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routes.profilePageBackIconRoute.moveTo(false);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Text(
              AppStrings.more,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamilies.alexandria),
            ),
            SizedBox(
              width: 5.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: SvgPicture.asset(
                AppAssets.arrowIcon,
                width: 10.w,
                height: 10.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
