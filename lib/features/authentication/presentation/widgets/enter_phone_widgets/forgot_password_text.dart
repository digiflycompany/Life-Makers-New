import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.height32,bottom: context.height24),
      child: Text(
        AppStrings.forgetPasswordQuestion,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            color: AppColors.blueColor4,
            fontWeight: FontWeight.w500,
            fontSize: 13.5.sp
        ),
      ),
    );
  }
}
