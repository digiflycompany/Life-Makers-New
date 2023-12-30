import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/campaign_details/repo/join_campaign_repository.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

import '../model/all_campains_model.dart';

class AllCampaignsCubit extends Cubit<CubitBaseState> {
  AllCampaignsCubit() : super(CubitBaseState.initial);

  CampaignRepository campaignRepository = CampaignRepository();

  AllCampainsModel? campaignsModel;
  Future<void> getAllCampaigns() async {
    emit(CubitBaseState.loading);
    Response? response = await campaignRepository.getAllCampaigns();
    if (response?.statusCode == 200) {
      campaignsModel = AllCampainsModel.fromJson(response?.data);
      emit(CubitBaseState.done);
    } else {
      emit(CubitBaseState.error);
    }
  }
}
