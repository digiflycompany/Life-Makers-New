import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/otp_image.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/otp_screen_body.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  return BlocProvider(
  create: (context) => SignUpCubit(),
  child: BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context,state){
        if (state is otpResetPasswordSubmitLoading) {
        } else if (state is otpResetPasswordSubmitSuccess) {
             Routes.changePasswordPageRoute.moveTo;
        } else if (state is otpResetPasswordSubmitFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            duration: Duration(seconds: 2),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const OtpImage(),
                    OtpScreenBody(formKey: _formKey,)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
);
  }
}