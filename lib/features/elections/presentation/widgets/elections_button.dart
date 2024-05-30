import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import '../../../../core/utils/app-color.dart';

class ElectionsButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const ElectionsButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20, bottom: 20,top: 10),

      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.orangeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),

          ),
          fixedSize: Size(double.infinity,60.h)
        ),
        onPressed: onTap,

        child: Center(
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
