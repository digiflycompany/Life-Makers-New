import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
//////////////////////TextField\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

class PasswordTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final   suffixIcon;
  final   prefixIcon;
  final validator;
  const PasswordTextField({Key? key, this.suffixIcon, this.controller, required this.hintText, required this.obscureText, this.validator, this.prefixIcon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      //height: context.height64,
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
                  SvgPicture.asset(AppAssets.passwordIcon,),
                  SizedBox(width:context.width8,),
                  Container(
                    width: 2.w,
                    height: context.height27,
                    color: AppColors.blueColor,
                  ),
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