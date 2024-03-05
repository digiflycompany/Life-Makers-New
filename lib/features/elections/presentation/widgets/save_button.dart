import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import '../../../../core/utils/app-color.dart';

class SaveButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const SaveButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 147.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: AppColors.orangeBorderColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child:  Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text!,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamilies.alexandria,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.5
              ),
            ),
            SizedBox(width: 6.w,),
            SvgPicture.asset(AppAssets.saveIcon),
          ],
        ),
      ),
    );
  }
}
