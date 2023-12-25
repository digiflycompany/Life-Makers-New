import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-color.dart';

class AuthButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const AuthButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 420.w,
        height: 63.h,
        decoration: BoxDecoration(
          color: AppColors.orangeBorderColor,
          borderRadius: BorderRadius.circular(8.r),
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
