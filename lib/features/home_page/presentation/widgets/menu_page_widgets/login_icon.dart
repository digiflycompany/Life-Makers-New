import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';

class LoginIcon extends StatelessWidget {
  const LoginIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: ()=> Routes.loginPageRoute.moveTo,
      child: Padding(
        padding: EdgeInsets.only(right: 15.7.w,bottom: 22.h,top: 22.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppStrings.loggingIn,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: FontFamilies.alexandria,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 11.w,
            ),
            Icon(Icons.login,color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
