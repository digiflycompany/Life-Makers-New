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

  Future<Response?> sendCampaignSuggestion(
      {required int taskId, required String suggestion}) async {
    Response? response = await DioHelper.postData(
        url: EndPoints.campaignSuggestion,
        data: {'task_id': taskId, 'suggestion': suggestion});

    return response;
  }


  Future<Response?> sendCampaignComplaign(
      {required int taskId, required String complaint}) async {
    Response? response = await DioHelper.postData(
        url: EndPoints.campaignComplaign,
        data: {'task_id': taskId, 'complaint': complaint});

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
