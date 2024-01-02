import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/campaign_details/model/user_joined_campaigns_model.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_states.dart';
import 'package:life_makers/features/volunteer_opportunity/models/one_day_activity_model.dart';
import 'package:life_makers/features/volunteer_opportunity/models/volunteer_repo.dart';
import 'package:life_makers/features/volunteer_opportunity/models/programs_model.dart';
import '../../../services/shared_preferences/preferences_helper.dart';
import '../../authentication/data/apis/api.dart';
import '../../home_page/data/models/user_joined_volunteers_model.dart';

class VolunteerCubit extends Cubit<VolunteerState> {
  VolunteerCubit() : super(VolunteerInitial());
  Dio dio = Dio();
  VolunteerPracticalTrainingModel? volunteerPracticalTrainingModel;
  UserJoinedVolunteerOpportunities? userJoinedVolunteerOpportunities;
  JoinedCampaignsModel? joinedCampaignsModel;
  OneDayActivityModel? oneDayActivityModel;

  VolunteerRepo? volunteerRepo = VolunteerRepoImp();
  Future<void> reset() async {
    emit(VolunteerInitial());
  }

  Future<void> getVolunteerProgramTraining() async {
    emit(VolunteerProgramLoading());
    try {
      Response? response =
          await volunteerRepo?.getVolunteersTrainingPractical();
      if (response?.statusCode == 200) {
        volunteerPracticalTrainingModel =
            VolunteerPracticalTrainingModel.fromJson(response?.data);
        emit(VolunteerProgramSuccess());
        print('Sucessssssssssssssssssssssssssssssssss');
      } else {
        emit(VolunteerProgramFailure('Something Went Wrong'));
      }
    } on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print(
              'Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(VolunteerProgramFailure('Something Went Wrong'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(VolunteerProgramFailure("Dio exception: ${dioException.message}"));
      }
    }
  }

  Future<void> JoinProgram(String programId) async {
    emit(UserJoinedProgramLoading());
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
        emit(UserJoinedProgramSuccess());
      } else {
        UserJoinedProgramFailure('حدث خطأ حاول مجددا');
      }
    } on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print(
              'Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(UserJoinedProgramFailure('حدث خطأ حاول مجددا'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(
            UserJoinedProgramFailure("Dio exception: ${dioException.message}"));
      }
    }
  }

  Future<void> leftProgram(String programId) async {
    emit(UserLeftProgramLoading());
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
        emit(UserLeftProgramSuccess());
      } else {
        UserLeftProgramFailure('حدث خطأ حاول مجددا');
      }
    } on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print(
              'Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(UserLeftProgramFailure('حدث خطأ حاول مجددا'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(UserLeftProgramFailure("Dio exception: ${dioException.message}"));
      }
    }
  }

  Future<void> getJoinedVolunteerOpportunities() async {
    emit(JoinedProgramLoading());
    try {
      Response response =
          await dio.get(
              options: Options(headers: {
                'Authorization': 'Bearer ${PreferencesHelper.getToken()}'
              }),
              EndPoints.userJoinedVolunteerOpportunities);
      if (response.statusCode == 200) {
        userJoinedVolunteerOpportunities= UserJoinedVolunteerOpportunities.fromJson(response.data);
        emit(JoinedProgramSuccess());
      } else {
        throw Exception('Failed to load program volunteer opportunities');
      }
    } catch (error) {
      emit(JoinedProgramFailure('Failed to load program volunteer opportunities: $error'));
    }
  }

  Future<void> getJoinedCampaigns() async {
    emit(JoinedCampaignsLoading());
    try {
      Response response =
      await dio.get(
          options: Options(headers: {
            'Authorization': 'Bearer ${PreferencesHelper.getToken()}'
          }),
          EndPoints.userJoinedCampaigns);
      if (response.statusCode == 200) {
        print(response.data);
        joinedCampaignsModel= JoinedCampaignsModel.fromJson(response.data);
        emit(JoinedCampaignsSuccess());
      } else {
        throw Exception('Failed to load campaigns');
      }
    } catch (error) {
      emit(JoinedCampaignsFailure('Failed to load campaigns: $error'));
    }
  }

}
