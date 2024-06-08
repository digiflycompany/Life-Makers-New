import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';

abstract class SeasonalCampaignsStates {}

class SeasonalCampaignsInitStates extends SeasonalCampaignsStates {}

class SeasonalCampaignsLoadingStates extends SeasonalCampaignsStates {}

class SeasonalCampaignsSuccessStates extends SeasonalCampaignsStates {
  final List<Campaigns> campaigns;

  SeasonalCampaignsSuccessStates({required this.campaigns});
}

class SeasonalCampaignsErrorStates extends SeasonalCampaignsStates {}

class SeasonalCampaignsChangePageStates extends SeasonalCampaignsStates {}
