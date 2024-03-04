import 'package:dio/dio.dart';
import 'package:life_makers/features/authentication/data/apis/api.dart';
import 'package:life_makers/services/dio_helper/dio_helper.dart';

abstract class CampaignsRepo {
  Future<Response?> getSeasonalCampaigns();
  Future<Response?> getNonSeasonalCampaigns();
}

class CampaignsRepoImpl implements CampaignsRepo {
  @override
  Future<Response?> getSeasonalCampaigns() async {
    Response? response =
        await DioHelper.getData(url: EndPoints.allSeasonalCampaigns);
    return response;
  }

  @override
  Future<Response?> getNonSeasonalCampaigns() async {
    Response? response =
        await DioHelper.getData(url: EndPoints.allNonSeasonalCampaigns);
    return response;
  }
}
