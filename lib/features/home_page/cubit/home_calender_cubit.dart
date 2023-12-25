import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';
import 'package:life_makers/features/home_page/repo/home_repo.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

class HomeCalenderCubit extends Cubit<CubitBaseState> {
  HomeCalenderCubit() : super(CubitBaseState.initial);

  HomeRepository homeRepository = HomeRepository();

  HomeCalenderModel? homeCalenderModel;

  Future<void> getHomeCalender() async {
    if (homeCalenderModel == null) {
      emit(CubitBaseState.loading);
      Response? response = await homeRepository.getHomeCalender();

      if (response?.statusCode == 200) {
        emit(CubitBaseState.done);
        homeCalenderModel = HomeCalenderModel.fromJson(response?.data);
      } else {
        emit(CubitBaseState.error);
      }
    }
  }
}
