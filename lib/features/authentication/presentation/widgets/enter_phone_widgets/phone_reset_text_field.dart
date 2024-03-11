import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/email_text_field.dart';

class PhoneResetTextField extends StatelessWidget {
  const PhoneResetTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return RegularTextField(
          max: 11,
          readOnly: false,
          keyboardType: TextInputType.number,
          controller: signUpCubit.phoneResetPasswordController,
          hintText: AppStrings.phoneNumber,
          obscureText: false,
          img: AppAssets.phoneIcon,
          validator: (value) {
            if (value!.isEmpty) {
              if (signUpCubit.phoneResetPasswordController.text.length < 11) {
                return AppStrings.pleaseEnterPhone;
              }
            } else if (value.length != 11) {
              return AppStrings.enterValidNumber;
            }
            return null;
          },
        );
      },
    );
  }
}
