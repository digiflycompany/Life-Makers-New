import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/pages/change_password.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/otp_image.dart';
import 'package:life_makers/features/authentication/presentation/widgets/otp_widgets/otp_screen_body.dart';
import 'package:page_transition/page_transition.dart';

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
          Navigator.pushReplacement(context, PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400),
            child:  BlocProvider.value(
              value: context.read<SignUpCubit>(),
              child: ChangePasswordScreen(),
            ),
          ),
          );
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