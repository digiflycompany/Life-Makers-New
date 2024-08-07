import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_fonts.dart';

class DrawerText extends StatelessWidget {
  final double font;
  final String text;
  final String img;
  const DrawerText({super.key,required this.text, required this.img, required this.font});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(right: 15.7.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(img),
          SizedBox(width:11.w,),
          Flexible(child:Text(
            text,
            style:  TextStyle(
              color: Colors.white,
              fontFamily: FontFamilies.alexandria,
              fontSize: font,
              fontWeight: FontWeight.w500,
                height:1.2.h

            ),
            textDirection: TextDirection.rtl,
          )),
        ],
      ),
    );
  }
}
