import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app_fonts.dart';

class CustomRadio extends StatelessWidget {
  final String title;
  final bool? selected;
  const CustomRadio({super.key,required this.title, required this.selected});

  @override
  Widget build(BuildContext context) {
    return  Row(
      textDirection: TextDirection.rtl,
      children: [
        Container(
          width: 17,
          height: 17,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.greyColor5,width: 2.w)
          ),
          child:selected==true? Center(
            child: Container(
              width: 11.w,
              height: 11.h,
              decoration: const BoxDecoration(
                color: AppColors.blueColor,
                shape: BoxShape.circle,
                //border: Border.all(color: Colors.transparent,width: 2.w)
              ),
            ),
          ):Center(
            child: Container(
              width: 11.w,
              height: 11.h,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                //border: Border.all(color: Colors.transparent,width: 2.w)
              ),
            ),
          )
        ),
        SizedBox(width: 10.w,),
        Text(
          title,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: FontFamilies.alexandria,
              fontSize: 10.5,
              fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(width: 10.w,),
        SvgPicture.asset(AppAssets.arrowRadioButton),
      ],
    );
  }
}
