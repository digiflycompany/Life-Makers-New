import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/auth_button.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButton({super.key, required this.formKey});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        LoginCubit loginCubit = context.read<LoginCubit>();
        return AuthButton(
          text: AppStrings.enter,
          onTap: () {
            if (formKey.currentState!.validate()) {
              final username = loginCubit.emailController.text;
              final password = loginCubit.passwordController.text;
              loginCubit.login(username, password);
            }
          },
        );
      },
    );
  }
}
