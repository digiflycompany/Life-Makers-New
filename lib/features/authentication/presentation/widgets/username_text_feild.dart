// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app_fonts.dart';

//////////////////////TextField\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

class UsernameTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final double? space = 8.w;
  double? iconWidth =18.w;
  double? iconHeight =18.h ;
  final String img;
  final controller;
  final String hintText;
  final bool obsecureText;
  final  suffixicon;
  final validator;
  bool readOnly =false;
  final Function()? onChanged;
   UsernameTextField({Key? key, this.suffixicon, this.controller, required this.hintText, required this.obsecureText, this.validator, required this.img, this.iconWidth, this.iconHeight, this.onChanged,  this.keyboardType, this.readOnly=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: TextFormField(
        maxLength: 10,
        readOnly:readOnly,
        keyboardType:keyboardType ,
        cursorColor: AppColors.blueColor6,
        cursorWidth: 2.w,
        textDirection: TextDirection.rtl,
        validator: validator,
        controller: controller,
        obscureText: obsecureText,
        inputFormatters: [
          FilteringTextInputFormatter.deny(
              RegExp(r'\s')),
        ],
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
          errorMaxLines: 1,
          errorBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.redColor),
              borderRadius: BorderRadius.circular(8.r)
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.redColor),
              borderRadius: BorderRadius.circular(8.r)
          ),
          errorStyle: TextStyle(
            color: AppColors.redColor,
            fontFamily: FontFamilies.alexandria,// Customize the error text color
            fontSize: 10, // Customize the error text font size
          ),
          focusColor: AppColors.blueColor7,
          alignLabelWithHint: true,
          hintTextDirection:TextDirection.rtl ,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.blueColor7),
              borderRadius: BorderRadius.circular(8.r)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.blueColor7),
            borderRadius: BorderRadius.circular(8.r),
          ),
          fillColor: Colors.white,
          filled:true,
          hintText: hintText,
          hintStyle: const TextStyle(
              color:AppColors.blueColor6,
              fontFamily: FontFamilies.alexandria,
              fontSize: 11,
              fontWeight: FontWeight.w400
          ),
          suffixIcon:  Padding(
            padding:  EdgeInsets.only(left: 16.w ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppAssets.dividerIcon,width: 22.w,height: 24.h,),
                SizedBox(width: 8.w,),
                SvgPicture.asset(img,width: iconWidth,height: iconHeight,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}