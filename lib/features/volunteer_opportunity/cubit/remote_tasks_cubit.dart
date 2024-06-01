import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/remote_tasks_states.dart';
import 'package:life_makers/features/volunteer_opportunity/models/remote_tasks_model.dart';
import 'package:life_makers/features/volunteer_opportunity/models/volunteer_repo.dart';

import '../../../services/shared_preferences/preferences_helper.dart';
import '../../authentication/data/apis/api.dart';


class RemoteTasksCubit extends Cubit<RemoteTasksState> {
  RemoteTasksCubit() : super(RemoteTasksInitial());
  Dio dio = Dio();
  RemoteTasksModel? remoteTasksModel;

  VolunteerRepo? volunteerRepo = VolunteerRepoImp();


  Future<void> getRemoteTasks() async {

      emit(RemoteTasksLoading());
      try {
        Response? response = await volunteerRepo
            ?.getRemoteTasks();
        if (response?.statusCode == 200) {
          remoteTasksModel =
              RemoteTasksModel.fromJson(response?.data);
          emit(RemoteTasksSuccess());
        } else {
          emit(RemoteTasksFailure('Something Went Wrong'));
        }
      } on DioException catch (dioException) {
        if (dioException.response != null) {
          if (kDebugMode) {
            print('Server responded with status code: ${dioException.response!.statusCode}');
          }
          emit(RemoteTasksFailure('Something Went Wrong'));
        } else {
          if (kDebugMode) {
            print('Dio exception: ${dioException.message}');
          }
          emit(RemoteTasksFailure("Dio exception: ${dioException.message}"));
        }
      }
    }

  Future<void> joinRemoteTasks(String remoteTaskId) async {
    emit(JoinRemoteTasksLoading());
    try {
      Response? response = await dio.post(
        EndPoints.userJoinVolunteer,
        options: Options(headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'}),
        data: {
          'volunteer_opportunity_id': remoteTaskId,
        },
      );
      if (response.statusCode == 200) {
        emit(JoinRemoteTasksSuccess());
      }else{
        JoinRemoteTasksFailure('حدث خطأ حاول مجددا');
      }
    }on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print('Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(JoinRemoteTasksFailure('حدث خطأ حاول مجددا'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(JoinRemoteTasksFailure("Dio exception: ${dioException.message}"));
      }
    }

  }

  Future<void> leftRemoteTasks(String remoteTaskId) async {
    emit(leftRemoteTasksLoading());
    try {
      Response? response = await dio.post(
        EndPoints.userLeftVolunteer,
        options: Options(headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'}),
        data: {
          'volunteer_opportunity_id': remoteTaskId,
        },
      );
      if (response.statusCode == 200) {
        emit(leftRemoteTasksSuccess());
      }else{
        leftRemoteTasksFailure('حدث خطأ حاول مجددا');
      }
    }on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print('Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(leftRemoteTasksFailure('حدث خطأ حاول مجددا'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(leftRemoteTasksFailure("Dio exception: ${dioException.message}"));
      }
    }

  }



}
