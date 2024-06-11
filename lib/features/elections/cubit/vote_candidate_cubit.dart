import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/elections/repo/elections_repo.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';

import '../presentation/pages/elections_thanks_screen.dart';

class VoteCandidateCubit extends Cubit<CubitBaseState> {
  VoteCandidateCubit() : super(CubitBaseState.initial);

  ElectionsRepoImpl? electionsRepoImpl = ElectionsRepoImpl();
  Dio dio = Dio(BaseOptions(
      headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'}));

  void voteForCandidates(
      {required List<int> votedList,
      required BuildContext context,
      required int managerId}) async {
    emit(CubitBaseState.loading);
    String url = 'https://app.digifly-eg.com/api/toggleVote';
    FormData formData = FormData.fromMap({
      'voters_id[0]': votedList[0],
      'voters_id[1]': votedList[1],
      'voters_id[2]': votedList[2],
      'voters_id[3]': votedList[3],
      'voters_id[4]': votedList[4],
      'voters_id[5]': votedList[5],
      'voters_id[6]': votedList[6],
      'voters_id[7]': votedList[7],
      'voters_id[8]': votedList[8],
      'voters_id[9]': votedList[9],
      'voters_id[10]': managerId,
    });

    await dio.post(url, data: formData).then((value) {
      if (kDebugMode) {
        print(value.statusCode);
      }
      if (value.statusCode == 200 && value.data['status'] == true) {
        emit(CubitBaseState.done);
        CustomSnackBars.showSuccessToast(title: 'تم التصويت بنجاح');
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 200),
                child: const ElectionsThanksScreen()));
      } else {
        emit(CubitBaseState.error);
        CustomSnackBars.showErrorToast(title: '${value.data['msg']}');
      }
    });
  }
}
