import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_states.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/repo/seasonal_campaigns_repo.dart';
import 'package:life_makers/services/dio_helper/error_handler.dart';

class SeasonalCampaignsCubit extends Cubit<SeasonalCampaignsStates> {
  SeasonalCampaignsCubit(int initialPage)
      : currentPage = initialPage,
        super(SeasonalCampaignsInitStates()) {
    pageController = PageController(initialPage: initialPage);
  }

  late PageController pageController;
  int currentPage;

  void changePageView(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void changCurrentPage(int page) {
    currentPage = page;
    emit(SeasonalCampaignsChangePageStates());
  }

  CampaignsModel? seasonalCampaignsModel;
  CampaignsRepoImpl? campaignsRepoImpl = CampaignsRepoImpl();

  Future<void> getSeasonalCampaignsRepo({required BuildContext context}) async {
    if (seasonalCampaignsModel == null) {
      emit(SeasonalCampaignsLoadingStates());

      Response? response = await campaignsRepoImpl?.getSeasonalCampaigns();

      if (response?.statusCode == 200) {
        seasonalCampaignsModel = CampaignsModel.fromJson(response?.data);

        // Combine all campaigns into a single list
        List<Campaigns> allCampaigns = [];
        if (seasonalCampaignsModel?.currentCampaigns != null) {
          allCampaigns.addAll(seasonalCampaignsModel!.currentCampaigns!);
        }
        if (seasonalCampaignsModel?.pastCampaigns != null) {
          allCampaigns.addAll(seasonalCampaignsModel!.pastCampaigns!);
        }
        if (seasonalCampaignsModel?.nextCampaigns != null) {
          allCampaigns.addAll(seasonalCampaignsModel!.nextCampaigns!);
        }

        emit(SeasonalCampaignsSuccessStates(campaigns: allCampaigns));
      } else {
        emit(SeasonalCampaignsErrorStates());
        errorHandler(context: context, response: response);
      }
    }
  }

  void resetState() {
    emit(SeasonalCampaignsInitStates as SeasonalCampaignsStates);
  }
}
