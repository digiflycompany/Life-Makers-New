import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import '../../../../core/utils/app-color.dart';

class Button extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const Button({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320.w,
        height: 63.h,
        decoration: BoxDecoration(
          color: AppColors.orangeBorderColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child:  Center(
          child: Text(
            text!,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w500,
                fontSize: 13
            ),
          ),
        ),
      ),
    );
  }
}
