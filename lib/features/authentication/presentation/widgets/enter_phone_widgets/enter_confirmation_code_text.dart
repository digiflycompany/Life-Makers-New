import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';

class EnterConfirmationCodeText extends StatelessWidget {
  const EnterConfirmationCodeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.height40),
      child: Text(
        AppStrings.enterPhoneNumberForConfirmation,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            color: AppColors.smallTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 10.8.sp
        ),
      ),
    );
  }
}
