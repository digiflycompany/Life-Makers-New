import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/enter_phone_body.dart';
import 'package:life_makers/features/authentication/presentation/widgets/enter_phone_widgets/enter_phone_image.dart';

class EnterPhoneScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SignUpCubit(),
  child: BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        SignUpCubit signUpCubit = context.read<SignUpCubit>();
        if(state is otpResetPasswordSentLoading){
          signUpCubit.phoneResetPasswordLoading =true;
        } else if(state is otpResetPasswordSentSuccess){
          signUpCubit.phoneResetPasswordLoading =false;
          Routes.otpPageRoute.moveTo;
        } else if(state is otpResetPasswordSentFailure){
          CustomSnackBars.showErrorToast(title: state.error);
          signUpCubit.phoneResetPasswordLoading =false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child:  Column(
                children: [
                  const EnterPhoneImage(),
                  EnterPhoneBody(),
                ],
              ),
            ),
          ),
        );
      },
    ),
);
  }
}