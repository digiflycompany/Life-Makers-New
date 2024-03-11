import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/button_circular_progress.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/data/models/phone_user_mode.dart';
import 'package:life_makers/features/authentication/presentation/widgets/confirmation_button.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class ConfirmOtpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const ConfirmOtpButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        return ConfirmationButton(
          onTap: () {
            if(signUpCubit.otpController.isNull
            ){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(AppStrings.pleaseEnterOtp),
                duration: Duration(seconds: 2),
              ));
            }else {
              PhoneUserModel? phoneUserModel;
              phoneUserModel = PreferencesHelper.getPhoneUserModel;
              String? id = phoneUserModel?.user?.id.toString();
              signUpCubit.OtpRestPasswordSubmit(signUpCubit.otpController.text,id!);
            }
          },
          content: Center(
                child: state is otpResetPasswordSubmitLoading?ButtonCircularProgress():Text(
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
