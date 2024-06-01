import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';

import '../../../../../core/utils/app-color.dart';
import '../../../../../core/utils/app-string.dart';

class loginToAccountText extends StatelessWidget {
  const loginToAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Routes.loginPageRoute.moveTo,
      child: Padding(
        padding: EdgeInsets.only(left: context.width4),
        child: Text(
          AppStrings.loggingIn,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: AppColors.blueColor4,
            fontWeight: FontWeight.w500,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}
