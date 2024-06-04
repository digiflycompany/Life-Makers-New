import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/home_page_user_photo.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/user_name_and_progress_line.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: const Row(
        textDirection: TextDirection.rtl,
        children: [
          HomePageUserPhoto(),
          UserNameAndProgressLine(),
        ],
      ),
    );
  }
}
