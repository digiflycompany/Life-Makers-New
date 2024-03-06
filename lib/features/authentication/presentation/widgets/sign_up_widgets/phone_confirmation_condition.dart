import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/change_number_or_resend_code_button.dart';
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
              const ChangeNumberOrResendCodeButton(),
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
