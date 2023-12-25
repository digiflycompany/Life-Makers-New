import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/elections/models/all_candidates_model.dart';
import 'package:life_makers/features/elections/repo/elections_repo.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

import '../../../services/dio_helper/error_handler.dart';

class AllCandidatesCubit extends Cubit<CubitBaseState> {
  AllCandidatesCubit() : super(CubitBaseState.initial);

  AllCandidatesModel? allCandidatesModel;

  ElectionsRepoImpl? electionsRepoImpl = ElectionsRepoImpl();

  void getAllCandidates({required BuildContext context}) async {
    if (allCandidatesModel == null) {
      emit(CubitBaseState.loading);

      Response? response = await electionsRepoImpl?.getAllCandidates();
      if (response?.statusCode == 200) {
        allCandidatesModel = AllCandidatesModel.fromJson(response?.data);
          emit(CubitBaseState.done);
      } else {
        errorHandler(context: context, response: response);
        emit(CubitBaseState.error);
      }
    }
  }
}
