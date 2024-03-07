import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/enter_confirmation_code_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/enter_phone_image.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/forgot_password_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/phone_reset_text_field.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';

class EnterPhoneScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SignUpCubit(),
  child: BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        if(state is otpResetPasswordSentLoading){
          signUpCubit.phoneResetPasswordLoading =true;
        } else if(state is otpResetPasswordSentSuccess){
          signUpCubit.phoneResetPasswordLoading =false;
          Routes.otpPageRoute.moveTo;
        } else if(state is otpResetPasswordSentFailure){
          CustomSnackBars.showErrorToast(title: state.error);
          signUpCubit.phoneResetPasswordLoading =false;
        }
      },
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return Scaffold(
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const EnterPhoneImage(),
                    const ForgotPasswordText(),
                    const EnterConfirmationCodeText(),
                    const PhoneResetTextField(),
                    SizedBox(height: 75.h),
                    GestureDetector(
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          signUpCubit.OtpResetPasswordCheck(signUpCubit.phoneResetPasswordController.text);
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
                          child: signUpCubit.phoneResetPasswordLoading == true ?Transform.scale(
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