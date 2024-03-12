import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/pages/login_screen.dart';
import 'package:life_makers/features/authentication/presentation/widgets/change_password_widgets/change_password_image.dart';
import 'package:life_makers/features/authentication/presentation/widgets/change_password_widgets/change_password_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/change_password_widgets/create_new_password_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/change_password_widgets/reset_passwords_text_fields.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-string.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is changePasswordLoading) {
          } else if (state is changePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppStrings.passwordHasBeenChangedSuccessfully),
              duration: Duration(seconds: 2),
            ));
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 400),
                  child: BlocProvider.value(
                    value: context.read<SignUpCubit>(),
                    child: LoginScreen(),
                  ),
                ));
          } else if (state is changePasswordFailure) {
          }
        },
        builder: (context, state) {
          SignUpCubit signUpCubit = context.read<SignUpCubit>();
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const ChangePasswordImage(),
                      const CreateNewPasswordText(),
                      const ResetPasswordsTextFields(),
                      ChangePasswordButton(formKey: _formKey,),
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
