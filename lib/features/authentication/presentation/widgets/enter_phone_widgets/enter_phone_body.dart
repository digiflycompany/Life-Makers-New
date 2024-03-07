import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/confirm_phone_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/enter_confirmation_code_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/forgot_password_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/phone_reset_text_field.dart';

class EnterPhoneBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  EnterPhoneBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width20),
        child: Column(
          children: [
            const ForgotPasswordText(),
            const EnterConfirmationCodeText(),
            const PhoneResetTextField(),
            ConfirmPhoneButton(formKey: _formKey,),
          ],
        ),
      ),
    );
  }
}
