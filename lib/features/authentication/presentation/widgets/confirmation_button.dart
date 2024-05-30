import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-color.dart';

class ConfirmationButton extends StatelessWidget {
  final Function()? onTap;
  final Widget? content;

  const ConfirmationButton({super.key, required this.onTap, required this.content});

  @override
  Widget build(BuildContext context) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: context.height51,
            decoration: BoxDecoration(
              color: AppColors.orangeColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Center(
              child: content
            ),
          ),
        );
  }
}
