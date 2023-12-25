import 'package:dio/dio.dart';
import 'package:life_makers/features/authentication/data/apis/api.dart';
import 'package:life_makers/services/dio_helper/dio_helper.dart';

abstract class ElectionsRepo {
  Future<Response?> getAllCandidates();
}

class ElectionsRepoImpl implements ElectionsRepo {
  @override
  Future<Response?> getAllCandidates() async {
    Response? response =
        await DioHelper.getData(url: EndPoints.getAllCandidates);
    return response;
  }
}
