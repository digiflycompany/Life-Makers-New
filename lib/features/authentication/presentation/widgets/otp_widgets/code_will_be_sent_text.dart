import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';

class CodeWillBeSentText extends StatelessWidget {
  const CodeWillBeSentText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:context.height40*1.1),
      child: Text(
        AppStrings.codeWillBeSentToYou,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            color: AppColors.smallTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 11.sp
        ),
      ),
    );
  }
}
