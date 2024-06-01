import 'package:flutter/cupertino.dart';

import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app_fonts.dart';

class SmallText extends StatelessWidget {
  final String? text;
  SmallText({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
        text!,
        style: const TextStyle(
         color: AppColors.blueColor6,
         fontFamily: FontFamilies.alexandria,
         fontWeight: FontWeight.w400,
         fontSize: 11
        ),
    );
  }
}
