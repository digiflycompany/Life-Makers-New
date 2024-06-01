import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app_fonts.dart';

class MembersButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const MembersButton({super.key, required this.onTap, required this.text});

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