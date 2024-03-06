import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_body.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          LoginCubit loginCubit = context.read<LoginCubit>();
          if (state is LoginSuccess) {
            loginCubit.LoginSuccessful(
                context, loginCubit.emailController.text);
          } else if (state is LoginFailure) {
            CustomSnackBars.showErrorToast(title: state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoginImage(),
                  LoginBody(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
