import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/login_to_account_text.dart';

class SignInText extends StatelessWidget {
  const SignInText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.height16),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text(
              AppStrings.haveAnAccount,
              style: TextStyle(
                  color: AppColors.blueColor6,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp
              ),
            ),
            loginToAccountText(),
          ],
        ),
      ),
    );
  }
}
