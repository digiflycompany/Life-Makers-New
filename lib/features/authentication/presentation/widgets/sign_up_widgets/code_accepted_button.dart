import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';

class CodeAcceptedButton extends StatelessWidget {
  const CodeAcceptedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppStrings.codeAcceptedAlready),
          duration: Duration(seconds: 2),
        ));
      },
      child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: context.width152,
                height: context.height64,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Center(
                  child: Text(
                    AppStrings.confirmed,
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5.sp,
                      height: 1.2.h,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
