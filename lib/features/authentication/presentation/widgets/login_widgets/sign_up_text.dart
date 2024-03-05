import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/presentation/widgets/createAccountText.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.width24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            AppStrings.doNotHaveAccount,
            style: TextStyle(
                color: AppColors.smallTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 11.sp
            ),
          ),
          SizedBox(
            width: context.width4,
          ),
          CreateAccountText(),
        ],
      ),
    );
  }
}