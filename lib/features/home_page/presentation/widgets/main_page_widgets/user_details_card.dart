import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/activities_and_more_row.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/details_row.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/user_qr.dart';

import 'user_activities_row.dart';

class UserDetailsCard extends StatelessWidget {
  const UserDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 15.h),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: const LinearGradient(
              colors: [
                AppColors.blueColor,
                AppColors.blueColor5,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  const DetailsRow(),
                  const ActivitiesAndMore(),
                  const UserActivities(),
                ],
              ),
              const UserQR(),
            ],
          )),
    );
  }
}
