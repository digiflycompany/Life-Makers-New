import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/auth_button.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return AuthButton(
          text: AppStrings.createAccount,
          onTap: () {
            if (signUpCubit.isConfirmed == true &&
                signUpCubit.otpSent == true) {
              signUpCubit.handleSignUp();
            } else if (signUpCubit.isConfirmed == false ||
                signUpCubit.otpSent == false) {
              CustomSnackBars.showErrorToast(
                  title: AppStrings.pleaseConfirmPhoneNumber
              );
            }
          },
        );
      },
    );
  }
}
