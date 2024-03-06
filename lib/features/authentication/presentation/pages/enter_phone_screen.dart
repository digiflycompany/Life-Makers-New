// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/pages/otp_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../widgets/email_text_field.dart';

class EnterPhoneScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  bool loading =false;
  EnterPhoneScreen({super.key});
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final otpResetPasswordCubit = context.read<SignUpCubit>();
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if(state is otpResetPasswordSentLoading){
          loading =true;
        } else if(state is otpResetPasswordSentSuccess){
          loading =false;
          Navigator.pushReplacement(context, PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400),
            child:  BlocProvider.value(
              value: context.read<SignUpCubit>(),
              child: OtpScreen(),
            ),
          ),
          );
        } else if(state is otpResetPasswordSentFailure){
          CustomSnackBars.showErrorToast(title: state.error);
          loading =false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(child: SvgPicture.asset(AppAssets.forgotPassword)),
                    SizedBox(height: 30.h),
                    confirmationCodeText,
                    SizedBox(height: 22.h),
                    enterConfirmationCodeText,
                    SizedBox(height: 40.h,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          phoneTextField,
                          SizedBox(height: 75.h),
                          Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 7.w),
                              child: GestureDetector(
                                onTap: (){
                                  if(_formKey.currentState!.validate()){
                                    otpResetPasswordCubit.OtpResetPasswordCheck(phoneController.text);
                                  }
                                },
                                child: Container(
                                  width: 420.w,
                                  height: 63.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.orangeBorderColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child:  Center(
                                    child: loading == true ?Transform.scale(
                                      scale: 0.4,
                                      child: CircularProgressIndicator(
                                        color: AppColors.white,
                                      ),
                                    ):Text(
                                      AppStrings.send,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontFamilies.alexandria,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  get createNewPassword => Text(
    AppStrings.createNewPassowrd,
    textDirection: TextDirection.rtl,
    style: TextStyle(
        color: AppColors.gradientColor1,
        fontWeight: FontWeight.w500,
        fontSize: 13.5
    ),
  );
  get confirmationCodeText => Text(
    AppStrings.forgetPasswordQuestion,
    textDirection: TextDirection.rtl,
    style: TextStyle(
        color: AppColors.gradientColor1,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamilies.alexandria,
        fontSize: 13.5
    ),
  );
  get enterConfirmationCodeText => Text(
    AppStrings.enterPhoneNumberForConfirmation,
    textDirection: TextDirection.rtl,
    style: TextStyle(
        color: AppColors.smallTextColor,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamilies.alexandria,
        fontSize: 10.8
    ),
  );
  get phoneTextField => RegularTextField(
    max: 11,
    readOnly: false,
    keyboardType: TextInputType.number,
    controller: phoneController,
    hintText: AppStrings.phoneNumber,
    obscureText: false,
    img: AppAssets.phoneIcon,
    validator: (value){
      if (value!.isEmpty) {
        if(phoneController.text.length<11){
          return AppStrings.pleaseEnterPhone;
        }
      } else if (value.length != 11 ){
        return 'أدخل رقم هاتف صحيح';
      }
      return null;
    },
  );
}