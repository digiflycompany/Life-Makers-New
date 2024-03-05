// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/data/models/phone_user_mode.dart';
import 'package:life_makers/features/authentication/presentation/pages/change_password.dart';
import 'package:life_makers/features/authentication/presentation/pages/enter_phone_screen.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';

class OtpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  bool loading =false;
  int? idNumber;
  String code ='';
  final TextEditingController controller =TextEditingController();
  String id ='';
  @override
  Widget build(BuildContext context) {
    final otpCubit = BlocProvider.of<SignUpCubit>(context);

    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context,state){
        if (state is otpResetPasswordSubmitLoading) {
          loading =true;
        } else if (state is otpResetPasswordSubmitSuccess) {
          Navigator.pushReplacement(context, PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400),
            child:  BlocProvider.value(
              value: context.read<SignUpCubit>(),
              child: ChangePasswordScreen(),
            ),
          ),
          );
        } else if (state is otpResetPasswordSubmitFailure) {
          loading =false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            duration: Duration(seconds: 2),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: SvgPicture.asset(AppAssets.forgotPassword)),
                    SizedBox(height: 30.h),
                    confirmationCodeText,
                    SizedBox(height: 22.h),
                    enterConfirmationCodeText,
                    SizedBox(height: 45.h),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: OTPTextField(
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 55.w,
                        style: TextStyle(
                            fontSize: 17,
                            color: AppColors.orangeBorderColor,
                            fontWeight: FontWeight.w700
                        ),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.underline,
                        otpFieldStyle: OtpFieldStyle(
                            focusBorderColor: Colors.orange,
                            borderColor: Colors.black
                        ),
                        onCompleted: (pin) {
                          controller.text=pin;

                        },
                      ),
                    ),
                    SizedBox(height: 55.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        didNotReceiveOtp,
                        SizedBox(width: 3.w,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 400),
                              child:  BlocProvider.value(
                                value: context.read<SignUpCubit>(),
                                child:EnterPhoneScreen(),
                              ),
                            ),
                            );
                          },
                          child: Text(
                            AppStrings.resendOtp2,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: AppColors.gradientColor1,
                                fontWeight: FontWeight.w600,
                                fontFamily: FontFamilies.alexandria,
                                fontSize: 10.8
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 25.w),
                        child:GestureDetector(
                          onTap: (){
                            if(controller.isNull
                            ){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('من فضلك أدخل ال otp'),
                                duration: Duration(seconds: 2),
                              ));
                            }else {
                              PhoneUserModel? phoneUserModel;
                              phoneUserModel = PreferencesHelper.getPhoneUserModel;
                              idNumber= phoneUserModel?.user?.id;
                              if (kDebugMode) {
                                print (idNumber);
                              }
                              id = idNumber.toString();
                              if (kDebugMode) {
                                print(controller.text);
                              }
                              otpCubit.OtpRestPasswordSubmit(controller.text,id);
                              if (kDebugMode) {
                                print(id);
                              }
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
                                AppStrings.confirm,
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
            ),
          ),
        );
      },
    );
  }
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
    AppStrings.codeWillBeSentToYou,
    textDirection: TextDirection.rtl,
    style: TextStyle(
        color: AppColors.smallTextColor,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamilies.alexandria,
        fontSize: 10.8
    ),
  );
  get didNotReceiveOtp =>Text(
    AppStrings.didNotReceiveOtp,
    textDirection: TextDirection.rtl,
    style: TextStyle(
        color: AppColors.smallTextColor,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamilies.alexandria,
        fontSize: 10.8
    ),
  );
}