import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/forget_password_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/logging_in_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_email_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/sign_in_as_visitor.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/sign_up_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/welcome_back_text.dart';

class LoginBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
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
            LoginButton(
                formKey: _formKey),
            SignUpText(),
            SignInAsVisitor(),
          ],
        ),
      ),
    );
  }
}
