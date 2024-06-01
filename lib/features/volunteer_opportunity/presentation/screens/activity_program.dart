import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/widgets/one_day_activity_card.dart';

import '../../../../core/utils/app-string.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/title_text.dart';
 class ActivityProgram extends StatefulWidget {
  const ActivityProgram({super.key});

  @override
  State<ActivityProgram> createState() => _ActivityProgramState();
}

class _ActivityProgramState extends State<ActivityProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: CustomAppBar('اختر نشاط'),
        preferredSize: Size(double.infinity, 50.h),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Expanded(child: OneDayActivityCard()),
          ],
        ),
      ),
    );
  }
  get title => TitleText(
      text: AppStrings.chooseActivity);
  get popUpIcon => GestureDetector(
    onTap: (){
      Navigator.pop(context);
    },
    child: SvgPicture.asset(
      AppAssets.popUpIcon,
    ),
  );
  get header => Row(
    children: [
      SizedBox(width: 177.w,),
      title,
      SizedBox(width: 132.w,),
      popUpIcon,
    ],
  );
}
