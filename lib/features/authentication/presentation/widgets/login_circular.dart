import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/extensions.dart';

import '../../../../core/utils/app-color.dart';

class LoginCircular extends StatelessWidget {
  const LoginCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420.w,
      height: 63.h,
      decoration: BoxDecoration(
        color: AppColors.orangeBorderColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child:  Center(
        child: Transform.scale(
            scale: 0.5,
            child: CircularProgressIndicator(color: Colors.white,))
      ),
    );
  }
}
