import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/widgets/training_card.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/title_text.dart';

class TrainingPrograms extends StatefulWidget {
  const TrainingPrograms({super.key});


  @override
  State<TrainingPrograms> createState() => _TrainingProgramsState();
}

class _TrainingProgramsState extends State<TrainingPrograms> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar('اختر برنامج'),
        preferredSize: Size(double.infinity, 50.h),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Expanded(child: TrainingCard()),
          ],
        ),
      ),
    );
  }
  get title => TitleText(
      text: AppStrings.chooseProgram);
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
