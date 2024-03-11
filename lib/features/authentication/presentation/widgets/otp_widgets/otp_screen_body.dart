import 'package:flutter/material.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/code_not_sent_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/code_will_be_sent_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/confirm_otp_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/forget_password_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/otp_text_field.dart';

class OtpScreenBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const OtpScreenBody({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ForgetPasswordText(),
        const CodeWillBeSentText(),
        const OtpCustomTextField(),
        const CodeNotSentText(),
        ConfirmOtpButton(formKey: formKey,),
      ],
    );
  }
}
