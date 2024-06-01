import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

import '../../../../core/utils/app-color.dart';

class ChooseButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const ChooseButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 87.w,
        height: 37.h,
        decoration: BoxDecoration(
          color: AppColors.orangeColor,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child:  Center(
          child: Text(
            text!,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w500,
                fontSize: 11.5
            ),
          ),
        ),
      ),
    );
  }
}
