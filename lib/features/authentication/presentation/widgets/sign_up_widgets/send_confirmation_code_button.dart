import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';

class SendConfirmationCodeButton extends StatelessWidget {
  const SendConfirmationCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return GestureDetector(
          onTap: () {
            if (signUpCubit.phoneController.isNotNull &&
                signUpCubit.phoneController
                    .toString()
                    .length >= 11) {
              signUpCubit.OtpCheck(signUpCubit.phoneController.text);
            }
          },
          child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: context.width152,
                      height: context.height51,
                      decoration: BoxDecoration(
                          color: AppColors.orangeBorderColor,
                          borderRadius: BorderRadius.circular(5.r)),
                      child: state is OtpSendLoading
                          ? Center(
                        child: Transform.scale(
                          scale: 0.5,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                          : Center(
                        child: Text(
                          AppStrings.sendConfirmationCode,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.5.sp
                          ),
                        ),
                      )),
                ],
              )),
        );
      },
    );
  }
}
