import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-color.dart';

class NewsButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const NewsButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 360.w,
        margin:  EdgeInsets.symmetric(horizontal: 19.w,vertical: 20.h),
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.orangeBorderColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child:  Center(
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.joinCampaignIcon),
              SizedBox(width: 5.w,),
              Text(
                text!,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamilies.alexandria,
                    fontWeight: FontWeight.w500,
                    fontSize: 12
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class NewsButton2 extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const NewsButton2({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 380.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.orangeBorderColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child:  Center(
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssets.joinCampaignIcon),
              SizedBox(width: 5.w,),
              Text(
                text!,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamilies.alexandria,
                    fontWeight: FontWeight.w500,
                    fontSize: 12
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

