import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';
import 'package:life_makers/features/home_page/repo/calendar_campaigns_model.dart';
import 'package:life_makers/features/home_page/repo/home_repo.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

class HomeCalenderCubit extends Cubit<CubitBaseState> {
  HomeCalenderCubit() : super(CubitBaseState.initial);

  HomeRepository homeRepository = HomeRepository();

  HomeCalenderModel? homeCalenderModel;

  CalendarCampaignsModel? calendarCampaignsModel;

  Future<void> getHomeCalender() async {
    if (homeCalenderModel == null) {
      emit(CubitBaseState.loading);
      Response? response = await homeRepository.getHomeCalender();

      if (response?.statusCode == 200) {
        emit(CubitBaseState.done);
        homeCalenderModel = HomeCalenderModel.fromJson(response?.data);
        print('aaaaaaaaaaaaaaaaaaaaaaaaaa');
        print(response?.data);
      } else {
        emit(CubitBaseState.error);
      }
    }
  }
  Future<void> getCampaignDetails(String? url) async {
    if (homeCalenderModel == null) {
      emit(CubitBaseState.loading);
      Response? response = await homeRepository.getCampaignDetails(url);

      if (response?.statusCode == 200) {
        emit(CubitBaseState.done);
        calendarCampaignsModel = CalendarCampaignsModel.fromJson(response?.data);
        print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
        print(response?.data);
      } else {
        emit(CubitBaseState.error);
      }
    }
  }
}
