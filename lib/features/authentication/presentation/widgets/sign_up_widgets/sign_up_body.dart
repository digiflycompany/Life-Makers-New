import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/city_center_fields.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/confirm_password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/experience_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/id_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/location_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/name_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/phone_confirmation_condition.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/phone_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_in_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_email_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/signing_up_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/username_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/whats_app_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/work_text_field.dart';

class SignUpBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SigningUpText(),
          const SignInText(),
          const NameTextField(),
          VerticalSpace(context.height20),
          const UsernameTextField(),
          VerticalSpace(context.height20),
          const SignUpPasswordTextField(),
          VerticalSpace(context.height20),
          const SignUpConfirmPasswordTextField(),
          VerticalSpace(context.height20),
          const SignUpEmailTextField(),
          VerticalSpace(context.height20),
          const WhatsAppTextField(),
          VerticalSpace(context.height20),
          const IdTextField(),
          VerticalSpace(context.height20),
          const WorkTextField(),
          VerticalSpace(context.height20),
          const LocationTextField(),
          VerticalSpace(context.height20),
          CityAndCenterFields(),
          VerticalSpace(context.height20),
          const ExperienceTextField(),
          VerticalSpace(context.height20),
          const PhoneTextField(),
          VerticalSpace(context.height11),
          const PhoneConfirmationCondition(),
          VerticalSpace(context.height24),
          SignUpButton(formKey: _formKey,),
          VerticalSpace(context.height32),
        ],
      ),
    );
  }
}
