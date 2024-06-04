import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/more_icon.dart';

class ActivitiesAndMore extends StatelessWidget {
  const ActivitiesAndMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11 .w),
      child: const Row(
        children: [
          Text(
            AppStrings.activities,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamilies.alexandria,
            ),
          ),
          Spacer(),
          MoreIcon(),
        ],
      ),
    );
  }
}
