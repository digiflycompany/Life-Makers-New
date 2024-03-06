import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/password_text_field.dart';

class SignUpPasswordTextField extends StatelessWidget {
  const SignUpPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return PasswordTextField(
          controller: signUpCubit.passwordController,
          hintText: AppStrings.password,
          obscureText: signUpCubit.isPasswordVisible,
          prefixIcon: GestureDetector(
            onTap: () {
              signUpCubit.togglePasswordVisibility();
            },
            child: signUpCubit.isPasswordVisible
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
            if (value == null || value.isEmpty) {
              return AppStrings.pleaseEnterYourPassword;
            }
            if (value.length < 7) {
              return AppStrings.passwordMustContain7letters;
            }
            if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
              return AppStrings.passwordMustContainAtLeastOneCapital;
            }
            if (!RegExp(r'\d').hasMatch(value)) {
              return AppStrings.passwordMustContainAtLeastOneNumber;
            }
            if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
              return AppStrings.passwordMustContainAtLeastOneSpecialCharacter;
            }
            return null;
          },
        );
      },
    );
  }
}
