import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

class NewsText extends StatelessWidget {
  final String text;

  const NewsText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 13.h, right: 4.w),
      child: Text(
        text,
        maxLines: 2,
        textDirection: TextDirection.rtl,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          height: 2.h,
          color: Colors.white,
          fontFamily: FontFamilies.alexandria,
          fontWeight: FontWeight.w400,
          fontSize: 10.4.sp,
        ),
      ),
    );
  }
}
