import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/change_number_or_resend_code_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/code_accepted_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/send_confirmation_code_button.dart';

class PhoneConfirmationCondition extends StatelessWidget {
  const PhoneConfirmationCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return Column(
          children: [
            if (signUpCubit.otpSent == false)
              const SendConfirmationCodeButton(),
            if (signUpCubit.otpSent == true && signUpCubit.isConfirmed == false)
              const ChangeNumberOrResendCodeButton(),
            if (signUpCubit.isConfirmed == true && signUpCubit.otpSent == true)
               const CodeAcceptedButton(),
          ],
        );
      },
    );
  }
}
