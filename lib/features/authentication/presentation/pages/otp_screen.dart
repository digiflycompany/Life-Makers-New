// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/data/models/phone_user_mode.dart';
import 'package:life_makers/features/authentication/presentation/pages/change_password.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/code_not_sent_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/code_will_be_sent_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/otp_image.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/otp_text_field.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';
import '../widgets/otp_widgets/forget_password_text.dart';

class OtpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  bool loading =false;
  int? idNumber;
  String code ='';
  String id ='';
  @override
  Widget build(BuildContext context) {
  return BlocProvider(
  create: (context) => SignUpCubit(),
  child: BlocConsumer<SignUpCubit, SignUpState>(
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
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const OtpImage(),
                    const ForgetPasswordText(),
                    const CodeWillBeSentText(),
                    const OtpCustomTextField(),
                    const CodeNotSentText(),
                    Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 25.w),
                        child:GestureDetector(
                          onTap: (){
                            if(signUpCubit.otpController.isNull
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
                                print(signUpCubit.otpController.text);
                              }
                              signUpCubit.OtpRestPasswordSubmit(signUpCubit.otpController.text,id);
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
    ),
);
  }
}