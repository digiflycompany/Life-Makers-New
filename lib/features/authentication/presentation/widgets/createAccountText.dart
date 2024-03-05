import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';

class CreateAccountText extends StatelessWidget {
  const CreateAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: ()=>Routes.signUpPageRoute.moveTo,
      child: Text(
        AppStrings.createAccount,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: AppColors.gradientColor1,
          fontWeight: FontWeight.w500,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
