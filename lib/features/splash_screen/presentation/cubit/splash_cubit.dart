import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/splash_screen/presentation/cubit/splash_state.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';

// Cubit
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void performInitialization(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      if (context.read<SplashCubit>().state is SplashInitial) {
        context.read<SplashCubit>().emit(SplashSuccess());
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 700),
            child: PreferencesHelper.applicationFirstPage,
          ),
        );
      }
    });
  }
}