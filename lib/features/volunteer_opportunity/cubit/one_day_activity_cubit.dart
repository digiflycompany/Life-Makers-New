import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/one_day_activity_states.dart';
import 'package:life_makers/features/volunteer_opportunity/models/one_day_activity_model.dart';
import 'package:life_makers/features/volunteer_opportunity/models/volunteer_repo.dart';

import '../../../services/shared_preferences/preferences_helper.dart';
import '../../authentication/data/apis/api.dart';


class OneDayActivityCubit extends Cubit<OneDayActivityState> {
  OneDayActivityCubit() : super(OneDayActivityInitial());
  Dio dio = Dio();
  OneDayActivityModel? oneDayActivityModel;

  VolunteerRepo? volunteerRepo = VolunteerRepoImp();


  Future<void> getOneDayActivity() async {

      emit(OneDayActivityLoading());
      try {
        Response? response = await volunteerRepo
            ?.getOneDayActivity();
        if (response?.statusCode == 200) {
          oneDayActivityModel =
              OneDayActivityModel.fromJson(response?.data);
          emit(OneDayActivitySuccess());
        } else {
          emit(OneDayActivityFailure('Something Went Wrong'));
        }
      } on DioException catch (dioException) {
        if (dioException.response != null) {
          if (kDebugMode) {
            print('Server responded with status code: ${dioException.response!.statusCode}');
          }
          emit(OneDayActivityFailure('Something Went Wrong'));
        } else {
          if (kDebugMode) {
            print('Dio exception: ${dioException.message}');
          }
          emit(OneDayActivityFailure("Dio exception: ${dioException.message}"));
        }
      }
  }

  Future<void> JoinOneDayActivity(String oneDayActivityId) async {
    emit(JoinOneDayActivityLoading());
    if (kDebugMode) {
      print(oneDayActivityId);
    }
    try {
      Response? response = await dio.post(
        EndPoints.userJoinVolunteer,
        options: Options(headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'}),
        data: {
          'volunteer_opportunity_id': oneDayActivityId,
        },
      );
      if (response.statusCode == 200) {
        emit(JoinOneDayActivitySuccess());
      }else{
        JoinOneDayActivityFailure('حدث خطأ حاول مجددا');
      }
    }on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print('Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(JoinOneDayActivityFailure('حدث خطأ حاول مجددا'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(JoinOneDayActivityFailure("Dio exception: ${dioException.message}"));
      }
    }
  }

  Future<void> leftOneDayActivity(String oneDayActivityId) async {
    emit(leftOneDayActivityLoading());
    if (kDebugMode) {
      print(oneDayActivityId);
    }
    try {
      Response? response = await dio.post(
        EndPoints.userLeftVolunteer,
        options: Options(headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'}),
        data: {
          'volunteer_opportunity_id': oneDayActivityId,
        },
      );
      if (response.statusCode == 200) {
        emit(leftOneDayActivitySuccess());
      }else{
        leftOneDayActivityFailure('حدث خطأ حاول مجددا');
      }
    }on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print('Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(leftOneDayActivityFailure('حدث خطأ حاول مجددا'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(leftOneDayActivityFailure("Dio exception: ${dioException.message}"));
      }
    }
  }


}
