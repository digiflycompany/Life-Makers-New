import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/authentication/data/apis/api.dart';
import 'package:life_makers/features/home_page/data/models/emergency_campaigns_model.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:life_makers/services/dio_helper/dio_helper.dart';


class EmergencyCampaignsCubit extends Cubit<CubitBaseState> {
  EmergencyCampaignsCubit() : super(CubitBaseState.initial);
  EmergencyCampaignModel? emergencyCampaignModel;

  EmergencyCampaignsRepo? repo = EmergencyCampaignsRepo();
  Future<void> getEmergencyCampaignsData() async {
    if(emergencyCampaignModel==null){
      emit(CubitBaseState.loading);

      Response? response = await repo?.getEmergencyCampaigns();
      if (response?.statusCode == 200) {
        if (kDebugMode) {
          print(response);
        }
        emergencyCampaignModel =
            EmergencyCampaignModel.fromJson(response?.data);
        emit(CubitBaseState.done);
      } else {
        emit(CubitBaseState.error);
      }
    }
  }
}

class EmergencyCampaignsRepo {
  Future<Response?> getEmergencyCampaigns() async {
    Response? response =
        await DioHelper.getData(url: EndPoints.getEmergenyCampaigns);
    return response;
  }
}
