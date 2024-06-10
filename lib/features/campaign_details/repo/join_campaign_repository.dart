import 'package:dio/dio.dart';
import 'package:life_makers/services/dio_helper/dio_helper.dart';

import '../../authentication/data/apis/api.dart';

class CampaignRepository {

  Future<Response?> getAllCampaigns() async {
    Response? response = await DioHelper.getData(
        url: EndPoints.getAllCampaigns);
    return response;
  }
  Future<Response?> requestJoinCampaign({required int taskId}) async {
    Response? response = await DioHelper.postData(
        url: EndPoints.joinCampaign, data: {'task_id': taskId});

    return response;
  }
  Future<Response?> campaignCheckIn({required int campaignId}) async {
    Response? response = await DioHelper.postData(
        url: EndPoints.campaignCheckIn, data: {
          'campaign_id': campaignId,
    });
    return response;
  }

  Future<Response?> campaignCheckOut({required int campaignId}) async {
    Response? response = await DioHelper.postData(
        url: EndPoints.campaignCheckOut, data: {
          'campaign_id': campaignId,
    });
    return response;
  }

  Future<Response?> sendCampaignSuggestion(
      {required int? campaignId, required String suggestion}) async {
    Response? response = await DioHelper.postData(
        url: EndPoints.campaignSuggestion,
        data: {'campaign_id': campaignId, 'suggestion': suggestion});

    return response;
  }


  Future<Response?> sendCampaignComplaign(
      {required int? campaignId, required String complaint}) async {
    Response? response = await DioHelper.postData(
        url: EndPoints.campaignComplaign,
        data: {'campaignId': campaignId, 'complaint': complaint});

    return response;
  }
  Future<Response?> leaveCampaign(
      {required int taskId, required String ?leaveReason}) async {
    Response? response = await DioHelper.postData(
        url: EndPoints.leaveCampaign,
        data: {'campaign_task_id': taskId});

    return response;
  }
}
