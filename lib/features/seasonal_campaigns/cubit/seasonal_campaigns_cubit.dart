import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/repo/seasonal_campaigns_repo.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:life_makers/services/dio_helper/error_handler.dart';

class SeasonalCampaignsCubit extends Cubit<CubitBaseState> {
  SeasonalCampaignsCubit() : super(CubitBaseState.initial);

  CampaignsModel? seasonalCampaignsModel;

  CampaignsRepoImpl? campaignsRepoImpl = CampaignsRepoImpl();

  Future<void> getSeasonalCampaignsRepo({required BuildContext context}) async {
    if (seasonalCampaignsModel == null) {
      emit(CubitBaseState.loading);

      Response? response = await campaignsRepoImpl?.getSeasonalCampaigns();

      if (response?.statusCode == 200) {
        seasonalCampaignsModel = CampaignsModel.fromJson(response?.data);

        emit(CubitBaseState.done);
      } else {
        emit(CubitBaseState.error);
        errorHandler(context: context, response: response);
      }
    }
  }
}
