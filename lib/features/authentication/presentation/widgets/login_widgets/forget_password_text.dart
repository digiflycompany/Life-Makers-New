import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.width6),
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: TextButton(
          onPressed: ()=>Routes.enterPhonePageRoute.moveTo,
          style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              padding: EdgeInsets.zero,
              minimumSize: Size(50, 30),
              tapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft),
          child: Text(
            AppStrings.forgetPassword,
            style: TextStyle(
                color: AppColors.smallTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 11.sp
            ),
          ),
        ),
      ),
    );
  }
}
