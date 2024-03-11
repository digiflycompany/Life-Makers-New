import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/spacer.dart';

class CodeNotSentText extends StatelessWidget {
  const CodeNotSentText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.height51,bottom:context.height32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            AppStrings.didNotReceiveOtp,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                color: AppColors.smallTextColor,
                fontWeight: FontWeight.w400,
                fontSize: 11.sp
            ),
          ),
          HorizontalSpace(3.w,),
          GestureDetector(
            onTap: () => Routes.enterPhonePageRoute.moveTo,
            child: Text(
              AppStrings.resendOtp2,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: AppColors.gradientColor1,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp
              ),
            ),
          ),
        ],
      ),
    );
  }
}
