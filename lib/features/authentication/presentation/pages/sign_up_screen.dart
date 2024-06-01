import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_body.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_logo.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit()
        ..fetchCityData()
        ..fetchAreaData(),
      child: BlocConsumer<SignUpCubit, SignUpState>(listener: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        switch (state.runtimeType) {
          case SignUpSuccess:
            Routes.mainPageRoute.moveToCurrentRouteAndRemoveAll();
            break;
          case OtpSendSuccess:
            signUpCubit.otpSent = true;
            break;
          case OtpSubmitSuccess:
            signUpCubit.isConfirmed = true;
            break;
          case OtpResend:
            signUpCubit.resend = true;
            break;
          case OtpResendCycleState:
            signUpCubit.otpSent = false;
            signUpCubit.phoneController.clear();
            break;
        }
      }, builder: (context, state) {
        return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width20),
                child: Column(
                  children: [
                    const SignUpLogo(),
                    SignUpBody(),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
