import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_states.dart';
import '../../../../core/utils/app-color.dart';

class AuthButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;

  const AuthButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: context.height51,
            decoration: BoxDecoration(
              color: AppColors.orangeBorderColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Center(
              child: state is LoginLoading ? Transform.scale(
                  scale: 0.6,
                  child: CircularProgressIndicator.adaptive()):Text(
                text!,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
