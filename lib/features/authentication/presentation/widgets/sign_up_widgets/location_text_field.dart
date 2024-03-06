import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/email_text_field.dart';

class LocationTextField extends StatelessWidget {
  const LocationTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return RegularTextField(
          max: 60,
          controller: signUpCubit.addressController,
          hintText: AppStrings.address,
          obscureText: false,
          img: AppAssets.locationIcon,
          validator: (value) {
            if (value!.isEmpty) {
              return AppStrings.pleaseEnterAddress;
            }
            return null;
          },
        );
      },
    );
  }
}
