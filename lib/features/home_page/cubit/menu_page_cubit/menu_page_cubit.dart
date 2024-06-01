import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/home_page/data/models/app_settings_model.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

import '../../../authentication/data/apis/api.dart';
import 'menu_page_states.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial());
  Dio dio = Dio();
  AppSettingsModel? appSettingsModel;
  Future<void> deleteAccount() async {
    emit(DeleteAccountInProgress());
    try {
      final response = await Dio().delete(
          EndPoints.deleteAccount,
        options: Options(headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'}),
      );

      if (kDebugMode) {
        print(response);
      }
      if (response.statusCode == 200) {
        emit(DeleteAccountSuccess());
      } else {
        emit(DeleteAccountFailure('Failed to delete account'));
      }
    } catch (e) {
      emit(DeleteAccountFailure('Failed to delete account: $e'));
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print(PreferencesHelper.getToken());
      }
    }
  }
  bool isVisible =false;
  // String? apiDateString = appSettingsModel?.data?.electionsStartDate;
  // DateTime? startTime;
  // DateTime? endTime;

  void toggleCampaigns() {
    isVisible = !isVisible;
    emit(MenuInitial());
  }

  Future<void> fetchDateAndTime() async{
    emit(fetchDateTimeLoading());
    try{
      Response response =
      await dio.get(EndPoints.appSettings);
      if (response.statusCode == 200) {
        appSettingsModel= AppSettingsModel.fromJson(response.data);
        emit(fetchDateTimeSuccess());
      } else {
        throw Exception('Failed to Load Data');
      }
    }catch(error){
      emit(fetchDateTimeFailure('Failed to load program volunteer opportunities: $error'));
    }
  }
}