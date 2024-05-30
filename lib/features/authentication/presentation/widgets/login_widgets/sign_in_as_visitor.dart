import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class SignInAsVisitor extends StatelessWidget {
  const SignInAsVisitor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.height12,bottom: context.height40),
      child: InkWell(
        onTap: (){
          PreferencesHelper.saveIsVisitor(isVisitor: true);
          Routes.mainPageRoute.moveTo;
        },
        child: Text(
          AppStrings.enterAsVisitor, style: TextStyle(
            color: AppColors.blueColor2,
            fontWeight: FontWeight.w500,
            fontSize: 11.sp
        ),),
      ),
    );
  }
}
