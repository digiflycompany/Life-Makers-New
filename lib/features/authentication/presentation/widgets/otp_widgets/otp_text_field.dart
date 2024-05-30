import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpCustomTextField extends StatelessWidget {
  const OtpCustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: OTPTextField(
            length: 4,
            width: context.width,
            fieldWidth: context.width52,
            style: TextStyle(
                fontSize: 17.sp,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w700
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            otpFieldStyle: OtpFieldStyle(
                focusBorderColor: Colors.orange,
                borderColor: Colors.black
            ),
            onCompleted: (pin) {
              signUpCubit.otpController.text = pin;
            },
          ),
        );
      },
    );
  }
}
