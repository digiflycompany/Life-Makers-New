import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/email_text_field.dart';

class ExperienceTextField extends StatelessWidget {
  const ExperienceTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return RegularTextField(
          max: 60,
          controller: signUpCubit.previousExperienceController,
          hintText: AppStrings.experience,
          obscureText: false,
          img: AppAssets.experienceIcon,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.pleaseEnterPreviousExperience;
            }
            return null;
          },
        );
      },
    );
  }
}
