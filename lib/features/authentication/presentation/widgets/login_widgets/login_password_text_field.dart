import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/password_text_field.dart';

class LoginPasswordTextField extends StatelessWidget {
  const LoginPasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit loginCubit = context.read<LoginCubit>();
        return PasswordTextField(
          controller: loginCubit.passwordController,
          hintText: AppStrings.password,
          obscureText: loginCubit.isPasswordVisible,
          prefixIcon: GestureDetector(
            onTap: () {
              loginCubit.togglePasswordVisibility();
              print('sdsdsdsdsd');
            },
            child: loginCubit.isPasswordVisible
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
              return AppStrings.pleaseEnterYourPassword;
            }
            return null;
          },
        );
      },
    );
  }
}