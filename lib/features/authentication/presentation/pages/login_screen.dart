import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_circular.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/forget_password_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_email_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/logging_in_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_image.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/sign_in_as_visitor.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/sign_up_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/welcome_back_text.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoginImage(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.width20),
                      child: Column(
                        children: [
                          WelcomeBackText(),
                          LoggingInText(),
                          LoginEmailTextField(),
                          VerticalSpace(context.height20),
                          LoginPasswordTextField(),
                          VerticalSpace(context.height4),
                          ForgetPasswordText(),
                          state is LoginLoading ? LoginCircular() : LoginButton(
                              formKey: _formKey),
                          SignUpText(),
                          SignInAsVisitor(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
