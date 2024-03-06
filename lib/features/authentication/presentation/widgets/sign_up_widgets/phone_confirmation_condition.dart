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
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/send_confirmation_code_button.dart';

class PhoneConfirmationCondition extends StatelessWidget {
  const PhoneConfirmationCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return Column(
          children: [
            if (signUpCubit.otpSent == false)
              const SendConfirmationCodeButton(),
            if (signUpCubit.otpSent == true && signUpCubit.isConfirmed == false)
              GestureDetector(
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
                                width: 155.w,
                                height: 67.h,
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
                                    'تم ارسال الرمز \nادخل الرمز صحيحا للتأكيد',
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
                              SizedBox(
                                height: 18.h,
                              ),
                              if (signUpCubit.resend)
                                Padding(
                                  padding: EdgeInsets.only(left: 6.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      signUpCubit.resendOtpCycle();
                                    },
                                    child: Text(
                                      'تغيير الرقم/ إعادة الإرسال',
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
                                  'إعادة إرسال الرمز بعد',
                                  style: TextStyle(
                                      color: AppColors.orangeBorderColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.sp
                                  ),
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
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
              ),
            if (signUpCubit.isConfirmed == true && signUpCubit.otpSent == true)
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("تم التأكيد بالفعل"),
                    duration: Duration(seconds: 2),
                  ));
                },
                child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 155.w,
                          height: 67.h,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Center(
                            child: Text(
                              AppStrings.confirmed,
                              textDirection: TextDirection.rtl,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5.sp,
                                height: 1.2.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
          ],
        );
      },
    );
  }
}
