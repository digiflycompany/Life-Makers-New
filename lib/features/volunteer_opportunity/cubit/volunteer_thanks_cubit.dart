import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_thanks_states.dart';
import '../../../core/utils/app-string.dart';
import '../../../core/widgets/custom_snack_bar.dart';

// Cubit
class VolunteerThanksCubit extends Cubit<VolunteerThanksState> {
  VolunteerThanksCubit() : super(VolunteerThanksInitial());

  void performInitialization(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (context.read<VolunteerThanksCubit>().state is VolunteerThanksInitial) {
        context.read<VolunteerThanksCubit>().emit(VolunteerThanksSuccess());
        CustomSnackBars.showSuccessToast(title: AppStrings.volunteerJoinedSuccessfully,);
        Navigator.pop(context);
      }
    });
  }
}