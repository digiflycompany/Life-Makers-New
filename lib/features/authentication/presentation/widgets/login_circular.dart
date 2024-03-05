import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/app-color.dart';

class LoginCircular extends StatelessWidget {
  const LoginCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.orangeBorderColor,
          ),
        ),
        child: Transform.scale(
            scale: 0.8,
            child: CircularProgressIndicator.adaptive()),
      )
    );
  }
}
