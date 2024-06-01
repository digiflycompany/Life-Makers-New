import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

class SigningUpText extends StatelessWidget {
  const SigningUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        AppStrings.signingUp,
        style: TextStyle(
            color: AppColors.blueColor,
            fontFamily: FontFamilies.alexandria,
            fontSize: 15.sp
        ),
      ),
    );
  }
}
