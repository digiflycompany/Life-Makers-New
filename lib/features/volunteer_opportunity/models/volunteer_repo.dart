import 'package:dio/dio.dart';
import 'package:life_makers/features/authentication/data/apis/api.dart';
import 'package:life_makers/services/dio_helper/dio_helper.dart';

abstract class VolunteerRepo {
  Future<Response?> getVolunteersTrainingPractical();
  Future<Response?> getOneDayActivity();
  Future<Response?> getRemoteTasks();
}

class VolunteerRepoImp implements VolunteerRepo {
  @override
  Future<Response?> getVolunteersTrainingPractical() async {
    Response? response =
    await DioHelper.getData(url: EndPoints.VolunteerTrainingProgram);
    return response;
  }

  @override
  Future<Response?> getOneDayActivity() async {
    Response? response =
    await DioHelper.getData(url: EndPoints.oneDayActivity);
    return response;
  }
  @override
  Future<Response?> getRemoteTasks() async {
    Response? response =
    await DioHelper.getData(url: EndPoints.remoteTasks);
    return response;
  }

}
