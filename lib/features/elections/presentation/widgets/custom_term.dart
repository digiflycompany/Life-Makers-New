import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app_fonts.dart';

class CustomTerm extends StatelessWidget {
  final double height;
  final String text;
  const CustomTerm({super.key, required this.text, required this.height});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.orangeBorderColor,
          radius: 8.5.r
        ),
        SizedBox(width: 12.w,),
        Padding(
          padding:  EdgeInsets.only(top: height),
          child: SizedBox(
            width: 280.w,
            child: Text(
              text,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  fontFamily: FontFamilies.alexandria,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }
}
