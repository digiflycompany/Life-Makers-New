import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

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
          color: AppColors.orangeColor,
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
          color: AppColors.orangeColor,
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

class NewsButton3 extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const NewsButton3({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 380.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.orangeColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child:  Center(
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/myEye.svg'),
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
class NewsButton4 extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final Color color;
  const NewsButton4({super.key, required this.onTap, required this.text, this.color=AppColors.orangeColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child:  Center(
          child: Text(
            text!,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w500,
                fontSize: 12
            ),
          ),
        ),
      ),
    );
  }
}

class PendingButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const PendingButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 380.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.greyColor3,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child:  Center(
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text!,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamilies.alexandria,
                    fontWeight: FontWeight.bold,
                    fontSize: 13
                ),
              ),
              SizedBox(width: 5.w,),
              Icon(Icons.watch_later,color: Colors.white,size: 18,),
            ],
          ),
        ),
      ),
    );
  }
}

