import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app_fonts.dart';
//////////////////////TextField\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

class PasswordTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final  suffixicon;
  final   prefixIcon;
  final validator;
  const PasswordTextField({Key? key, this.suffixicon, this.controller, required this.hintText, required this.obscureText, this.validator, this.prefixIcon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          textDirection: TextDirection.rtl,
          textInputAction: TextInputAction.next,
          cursorColor: AppColors.smallTextColor,
          cursorWidth: 2.w,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
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
            focusColor: AppColors.borderColor,
            alignLabelWithHint: true,
            hintTextDirection:TextDirection.rtl ,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(8.r)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(8.r),
            ),
            fillColor: Colors.white,
            filled:true,
            hintText: hintText,
            hintStyle: const TextStyle(
                color:AppColors.smallTextColor,
                fontFamily: FontFamilies.alexandria,
                fontSize: 11,
                fontWeight: FontWeight.w400
            ),
            prefixIcon:  Padding(
              padding:  EdgeInsets.only(right: 16.w ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppAssets.passwordIcon,width: 15.w,height: 15.h,),
                  SizedBox(width: 8.w,),
                  SvgPicture.asset(AppAssets.dividerIcon,width: 22.w,height: 24.h,),
                ],
              ),
            ),
            suffixIcon:prefixIcon
          ),
        ),
      ),
    );
  }
}