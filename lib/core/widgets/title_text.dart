import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

class TitleText extends StatelessWidget {
final   String? text;
  TitleText({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
        text!,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: FontFamilies.alexandria,
          fontSize: 12,
          fontWeight: FontWeight.w700
        ),
    );
  }
}
