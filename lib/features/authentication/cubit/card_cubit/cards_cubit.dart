import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/card_states.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';
import '../../data/apis/api.dart';
import '../../data/models/current_joined_campaigns_and_opp.dart';

class CardCubit extends Cubit<CardStates> {
  CardCubit() : super(CardInitial());
  CardCubit getCubit(context) => BlocProvider.of(context);
  Dio dio = Dio();
  CurrentJoinedCampaignsAndOpp? currentJoinedCampaignsAndOpp;

  Future<void> GetCurrentJoinedCampaignsAndOpp() async {
    emit(CardLoading());

    Response? response = await dio.get(
      EndPoints.currentCampaignsAndOpportunities,
      options: Options(headers: {
        'Authorization': 'Bearer ${PreferencesHelper.getToken()}'
      }),
    );
    if (response.statusCode == 200) {
      currentJoinedCampaignsAndOpp = CurrentJoinedCampaignsAndOpp.fromJson(response.data);
      emit(CardSuccess());
    } else {
      CardFailure('حدث خطأ حاول مجددا');
    }

  }

  Future<void> JoinProgram(String programId) async {
    emit(JoinedVolunteerLoading());
    if (kDebugMode) {
      print(programId);
    }
    try {
      Response? response = await dio.post(
        EndPoints.userJoinVolunteer,
        options: Options(headers: {
          'Authorization': 'Bearer ${PreferencesHelper.getToken()}'
        }),
        data: {
          'volunteer_opportunity_id': programId,
        },
      );
      if (response.statusCode == 200) {
        emit(JoinedVolunteerSuccess());
      } else {
        JoinedVolunteerFailure('حدث خطأ حاول مجددا');
      }
    } on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print(
              'Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(JoinedVolunteerFailure('حدث خطأ حاول مجددا'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(
            JoinedVolunteerFailure("Dio exception: ${dioException.message}"));
      }
    }
  }

  Future<void> leftProgram(String programId) async {
    emit(leftVolunteerLoading());
    if (kDebugMode) {
      print(programId);
    }
    try {
      Response? response = await dio.post(
        EndPoints.userLeftVolunteer,
        options: Options(headers: {
          'Authorization': 'Bearer ${PreferencesHelper.getToken()}'
        }),
        data: {
          'volunteer_opportunity_id': programId,
        },
      );
      if (response.statusCode == 200) {
        emit(leftVolunteerSuccess());
      } else {
        leftVolunteerFailure('حدث خطأ حاول مجددا');
      }
    } on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print(
              'Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(leftVolunteerFailure('حدث خطأ حاول مجددا'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(leftVolunteerFailure("Dio exception: ${dioException.message}"));
      }
    }
  }

}
