import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/repo/seasonal_campaigns_repo.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

import '../../../services/dio_helper/error_handler.dart';

class NonSeasonalCampaignsCubit extends Cubit<CubitBaseState> {
  NonSeasonalCampaignsCubit() : super(CubitBaseState.initial);

  CampaignsModel? nonSeasonalCampaignsModel;

  CampaignsRepoImpl? seasonalCampaignsRepoImpl = CampaignsRepoImpl();

  Future<void> getNonSeasonalCampaignsRepo({
    required BuildContext context
}) async {
    if(nonSeasonalCampaignsModel==null)
      {
        emit(CubitBaseState.loading);

        Response? response =
        await seasonalCampaignsRepoImpl?.getNonSeasonalCampaigns();
        if (kDebugMode) {
          print(response);
        }
        if (response?.statusCode == 200) {
          nonSeasonalCampaignsModel =
              CampaignsModel.fromJson(response?.data);
          if (kDebugMode) {
            print(nonSeasonalCampaignsModel?.currentCampaigns?.length);
          }
          emit(CubitBaseState.done);
        } else {
          emit(CubitBaseState.error);
          errorHandler(context: context, response: response);

        }
      }
  }
}
