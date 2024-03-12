import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/button_circular_progress.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/confirmation_button.dart';

class ChangePasswordButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const ChangePasswordButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return Padding(
            padding: EdgeInsets.only(top: context.height32),
            child: ConfirmationButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      signUpCubit.ChangePassword(
                          signUpCubit.resetPasswordController.text,
                          signUpCubit.confirmResetPasswordController.text);
                    }
                        },
                  content: state is changePasswordLoading? const ButtonCircularProgress():Text(
                    AppStrings.confirm,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp
                    ),
                  ),
                  ),
               );
           },
    );
  }
}
