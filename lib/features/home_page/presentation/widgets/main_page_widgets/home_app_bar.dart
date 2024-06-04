import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/widgets/title_text.dart';
import 'package:life_makers/features/home_page/presentation/widgets/drawer_icon.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor3,
      elevation: 0,
      centerTitle: true,
      title: TitleText(text: AppStrings.mainPage),
      leadingWidth: 45.w,
      leading:DrawerIcon(),
    );
  }
}
