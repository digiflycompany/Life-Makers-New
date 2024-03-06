import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';

class ChangeNumberOrResendCodeButton extends StatelessWidget {
  const ChangeNumberOrResendCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return GestureDetector(
          onTap: () {
            signUpCubit.OtpSubmit(signUpCubit.controller.text);
          },
          child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: signUpCubit.resend == true ? 0.h : 12.h),
                    child: Column(
                      children: [
                        Container(
                          width: context.width152,
                          height: context.height64,
                          decoration: BoxDecoration(
                              color: AppColors.orangeBorderColor,
                              borderRadius:
                              BorderRadius.circular(5.r)),
                          child: state is OtpSubmitLoading
                              ? Center(
                            child: Transform.scale(
                              scale: 0.4,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          )
                              : Center(
                            child: Text(
                              AppStrings.codeHasBeenSentEnterTheCodeCorrectly,
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 9.5.sp,
                                height: 2.h,
                              ),
                            ),
                          ),
                        ),
                        VerticalSpace(context.height16),
                        if (signUpCubit.resend)
                          Padding(
                            padding: EdgeInsets.only(left: context.width6),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                signUpCubit.resendOtpCycle();
                              },
                              child: Text(
                                AppStrings.changeNumberOrdResendCode,
                                style: TextStyle(
                                    color:
                                    AppColors.orangeBorderColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 11.sp
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      OtpTextField(
                        textStyle: TextStyle(
                            color: AppColors.orangeBorderColor,
                            fontWeight: FontWeight.w600),
                        cursorColor: AppColors.orangeBorderColor,
                        fieldWidth: 35.w,
                        numberOfFields: 4,
                        focusedBorderColor:
                        AppColors.orangeBorderColor,
                        borderColor: Color(0xFF512DA8),
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) {
                          signUpCubit.controller.text = verificationCode;
                        }, // end onSubmit
                      ),
                      VerticalSpace(context.height16),
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Text(
                            AppStrings.sendCodeAfter,
                            style: TextStyle(
                                color: AppColors.orangeBorderColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp
                            ),
                          ),
                          HorizontalSpace(context.width6),
                          TimerCountdown(
                            descriptionTextStyle: TextStyle(
                                color: AppColors.orangeBorderColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp
                            ),
                            timeTextStyle: TextStyle(
                                color: AppColors.orangeBorderColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp
                            ),
                            format: CountDownTimerFormat.secondsOnly,
                            endTime: DateTime.now().add(
                              Duration(
                                seconds: 25,
                              ),
                            ),
                            onEnd: () {
                              signUpCubit.resendOtp();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
