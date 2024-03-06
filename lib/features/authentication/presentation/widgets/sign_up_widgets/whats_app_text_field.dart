import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/email_text_field.dart';

class WhatsAppTextField extends StatelessWidget {
  const WhatsAppTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return RegularTextField(
          max: 11,
          keyboardType: TextInputType.number,
          controller: signUpCubit.whatsappController,
          hintText: AppStrings.whatsAppNumber,
          obscureText: false,
          img: AppAssets.whatsAppIcon,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.pleaseEnterWhatsapp;
            } else if (value.length != 11) {
              return AppStrings.enterCorrectWhatsAppNumber;
            }
            return null;
          },
        );
      },
    );
  }
}
