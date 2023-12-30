import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final splashCubit = context.read<SplashCubit>();
    splashCubit.performInitialization(context);
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return Scaffold(body: splashImage);
      },
    );
  }

  get splashImage =>
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.splashScreen,),
              fit: BoxFit.cover,
            )
        ),
      );
}