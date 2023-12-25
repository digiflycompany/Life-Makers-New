import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-color.dart';

class TermsButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  const TermsButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.orangeBorderColor,
          borderRadius: BorderRadius.circular(6.r),
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
