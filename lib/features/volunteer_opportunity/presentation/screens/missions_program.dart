import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/widgets/remote_tasks_card.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/title_text.dart';
class MissionsProgram extends StatefulWidget {
  const MissionsProgram({super.key});

  @override
  State<MissionsProgram> createState() => _MissionsProgramState();
}

class _MissionsProgramState extends State<MissionsProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar('اختر المهام'),
        preferredSize: Size(double.infinity, 50.h),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Expanded(child: RemoteTasksCard())
          ],
        ),
      ),
    );
  }
  get title => TitleText(
      text: AppStrings.chooseMissions);
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
