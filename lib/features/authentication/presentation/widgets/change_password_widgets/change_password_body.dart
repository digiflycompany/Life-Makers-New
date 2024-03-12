import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/presentation/widgets/change_password_widgets/change_password_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/change_password_widgets/create_new_password_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/change_password_widgets/reset_passwords_text_fields.dart';

class ChangePasswordBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const ChangePasswordBody({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width20),
      child: Column(
        children: [
          const CreateNewPasswordText(),
          const ResetPasswordsTextFields(),
          ChangePasswordButton(formKey: formKey,),
        ],
      ),
    );
  }
}
