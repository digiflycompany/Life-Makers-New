// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-color.dart';

class RegularTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final double? space = 8.w;
  double? iconWidth = 0;
  double? iconHeight = 0;
  final String img;
  final controller;
  final String hintText;
  final bool obscureText;
  final suffixIcon;
  final validator;
  int max = 60;
  bool readOnly = false;
  final Function()? onChanged;
  RegularTextField(
      {Key? key,
      this.suffixIcon,
      this.controller,
      required this.hintText,
      required this.obscureText,
      this.validator,
      required this.img,
      this.iconWidth,
      this.iconHeight,
      this.onChanged,
      this.keyboardType,
      this.readOnly = false,
      this.max = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          textInputAction: TextInputAction.next,
          maxLength: max,
          readOnly: readOnly,
          keyboardType: keyboardType,
          cursorColor: AppColors.smallTextColor,
          cursorWidth: 2.w,
          textDirection: TextDirection.rtl,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.symmetric(vertical: context.height20, horizontal: context.width20),
            errorMaxLines: 1,
            errorBorder:OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.redColor),
                borderRadius: BorderRadius.circular(5.r)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.redColor),
                borderRadius: BorderRadius.circular(5.r)
            ),
            errorStyle: TextStyle(
              color: AppColors.redColor,
              fontSize: 10.sp, // Customize the error text font size
            ),
            focusColor: AppColors.borderColor,
            alignLabelWithHint: true,
            hintTextDirection:TextDirection.rtl ,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(5.r)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(5.r),
            ),
            fillColor: Colors.white,
            filled:true,
            hintText: hintText,
            hintStyle: TextStyle(
                color:AppColors.smallTextColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.w400
            ),
            prefixIcon:  Padding(
              padding:  EdgeInsets.only(right: context.width16,left: context.width6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(img,width: iconWidth,height: iconHeight,),
                  SizedBox(width:context.width8,),
                  Container(
                    width: 2.w,
                    height: context.height27,
                    color: AppColors.blueColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
