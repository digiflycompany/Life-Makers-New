import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          drawerText,
          SizedBox(width:11.w ,),
          drawerIcon,
        ],
      ),
    );
  }
  get drawerText =>  Text(
    text,
    style:  TextStyle(
        color: Colors.white,
        fontFamily: FontFamilies.alexandria,
        fontSize: font,
        fontWeight: FontWeight.w500
    ),
  );
  get drawerIcon => SvgPicture.asset(img);
}
