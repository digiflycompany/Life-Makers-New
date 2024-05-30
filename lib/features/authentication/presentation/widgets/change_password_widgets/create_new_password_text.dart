import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';

class CreateNewPasswordText extends StatelessWidget {
  const CreateNewPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.height51),
      child: Text(
        AppStrings.createNewPassowrd,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            color: AppColors.blueColor4,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
        ),
      ),
    );
  }
}
