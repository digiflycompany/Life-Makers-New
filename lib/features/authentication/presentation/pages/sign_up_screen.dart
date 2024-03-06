import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
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
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_logo.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/signing_up_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/username_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/whats_app_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/work_text_field.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            SignUpCubit signUpCubit = context.read<SignUpCubit>();
            if (state is SignUpSuccess) {
              Routes.mainPageRoute.moveToCurrentRouteAndRemoveAll;
            }
            else if (state is OtpSendSuccess) {
          signUpCubit.otpSent = true;
        } else if (state is OtpSubmitSuccess) {
          signUpCubit.isConfirmed = true;
        } else if (state is OtpResend) {
          signUpCubit.resend = true;
        } else if (state is OtpResendCycleState) {
          signUpCubit.otpSent = false;
          signUpCubit.phoneController.clear();
        }
      }, builder: (context, state) {
        return Scaffold(
            body: Form(
              // key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.width20),
                  child: Column(
                    children: [
                      const SignUpLogo(),
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

                      /// City And Center
                      VerticalSpace(context.height20),
                      const ExperienceTextField(),
                      VerticalSpace(context.height20),
                      const PhoneTextField(),
                      VerticalSpace(context.height11),
                      const PhoneConfirmationCondition(),
                      VerticalSpace(context.height24),
                      const SignUpButton(),
                      VerticalSpace(context.height32),
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
