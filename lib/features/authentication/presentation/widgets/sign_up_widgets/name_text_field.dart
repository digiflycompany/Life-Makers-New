import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/email_text_field.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return RegularTextField(
          controller: signUpCubit.nameController,
          hintText: AppStrings.name,
          obscureText: false,
          img: AppAssets.usernameIcon,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.pleaseEnterName;
            } else if (signUpCubit.nameController.text.isNumericOnly) {
              return 'name must contain letters';
            }
            return null;
          },
        );
      },
    );
  }
}
