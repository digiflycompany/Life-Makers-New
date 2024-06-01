import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

import '../../../../core/utils/app-color.dart';

class SendButton extends StatelessWidget {
  final Function()? onTap;
  const SendButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        height: 37.h,
        decoration: BoxDecoration(
          color: AppColors.orangeColor,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            const Text(
              AppStrings.send,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamilies.alexandria,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.5
              ),
            ),
            SizedBox(width: 2.w,),
            SvgPicture.asset(AppAssets.sendIcon,width: 17.w,),
          ],
        ),
      ),
    );
  }
}
