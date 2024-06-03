import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/widgets/title_text.dart';

class NotificationTitle extends StatelessWidget {
  const NotificationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 17.h,bottom: 20.h),
      child: Center(
        child: TitleText(text: AppStrings.notifications),
      ),
    );
  }
}
