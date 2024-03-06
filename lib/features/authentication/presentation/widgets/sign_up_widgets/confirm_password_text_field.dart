import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/password_text_field.dart';

class SignUpConfirmPasswordTextField extends StatelessWidget {
  const SignUpConfirmPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return PasswordTextField(
          controller: signUpCubit.confirmPasswordController,
          hintText: AppStrings.confirmPassword,
          obscureText: signUpCubit.isConfirmPasswordVisible,
          prefixIcon: GestureDetector(
            onTap: () {
              signUpCubit.toggleConfirmPasswordVisibility();
            },
            child: signUpCubit.isConfirmPasswordVisible
                ? Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Transform.scale(
                  scale: 0.49,
                  child: SvgPicture.asset(AppAssets.hideIcon)),
            )
                : Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Transform.scale(
                  scale: 0.49,
                  child: SvgPicture.asset(AppAssets.showIcon)),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.pleaseConfirmPassword;
            } else if (signUpCubit.confirmPasswordController.text !=
                signUpCubit.passwordController.text) {
              return AppStrings.passwordNotMatching;
            }

            return null;
          },
        );
      },
    );
  }
}
