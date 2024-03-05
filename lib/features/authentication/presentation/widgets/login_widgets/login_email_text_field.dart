import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/email_text_field.dart';

class LoginEmailTextField extends StatelessWidget {
  const LoginEmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit loginCubit = context.read<LoginCubit>();
        return RegularTextField(
          max: 60,
          controller: loginCubit.emailController,
          img: AppAssets.mailIcon,
          hintText: AppStrings.email,
          obscureText: false,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.pleaseEnterYourEmail;
            }
            return null;
          },
        );
      },
    );
  }
}
