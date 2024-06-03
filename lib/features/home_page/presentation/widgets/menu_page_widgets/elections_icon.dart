import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/home_page/presentation/widgets/drawer_text.dart';

class ElectionsIcon extends StatelessWidget {
  const ElectionsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          // if( DateTime.now().isAfter(startTime!) && DateTime.now().isBefore(endTime!))
          // {
          //   Navigator.push(
          //       context,
          //       PageTransition(
          //           type: PageTransitionType.fade,
          //           duration: const Duration(milliseconds: 280),
          //           child: const TermsPage()));
          // }
          CustomSnackBars.showRegularToast(title: AppStrings.electionsSoon);
        },
        child: Padding(
          padding: EdgeInsets.only(top: 22.h),
          child: DrawerText(
              text:
              AppStrings.volunteerBoardOfDirectorsElections,
              img: AppAssets
                  .volunteerBoardOfDirectorsElectionsIcon,
              font: 11.sp),
        ));
  }
}
