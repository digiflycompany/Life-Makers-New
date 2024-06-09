import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/widgets/spacer.dart';

class UploadImage extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color color;
  const UploadImage({super.key, required this.text, this.onTap, this.color=Colors.white});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DottedBorder(
            radius: Radius.circular(5.r),
            borderType: BorderType.RRect,
            child: Container(
              color: color,
              width: double.infinity,
              height: 84.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.uploadIcon,width: 22.w,),
                  HorizontalSpace(10.w),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppColors.greyColor8,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamilies.alexandria,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalSpace(12.h),
          Text(
            ' (PNG - JPG بصيغة) حجم الصورة لا يزيد عن 2 ميجابايت',
            style: TextStyle(
              color: AppColors.greyColor4,
              fontFamily: FontFamilies.alexandria,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
