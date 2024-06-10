import 'package:dio/dio.dart';
import 'package:life_makers/services/dio_helper/dio_helper.dart';

import '../../authentication/data/apis/api.dart';

class HomeRepository {
  Future<Response?> getHomeCalender() async {
    Response? response = await DioHelper.
    getData(url: EndPoints.homeCalender);
    return response;
  }
  Future<Response?> getCampaignDetails(String? url) async {
    Response? response = await DioHelper.
    getData(url: url!);
    return response;
  }
}
