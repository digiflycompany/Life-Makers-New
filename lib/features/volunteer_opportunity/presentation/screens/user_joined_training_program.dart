import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/widgets/user_joined_programs_card.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/widgets/title_text.dart';
 class UserJoinedPrograms extends StatefulWidget {
   const UserJoinedPrograms({super.key});

  @override
  State<UserJoinedPrograms> createState() => _UserJoinedProgramsState();
}

class _UserJoinedProgramsState extends State<UserJoinedPrograms> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       body: SafeArea(
         child: Column(
           children: [
             SizedBox(height: 10.h,),
             Expanded(child: JoinedProgramCard()),
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
