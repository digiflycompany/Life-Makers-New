import 'package:dio/dio.dart';
import 'package:life_makers/features/authentication/data/apis/api.dart';
import 'package:life_makers/services/dio_helper/dio_helper.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class EditAccountRepository {
  Future<Response?> editAccountData({
    required String name,
    required String email,
    required String phone,
      required String address,
    required String job,
     required String governorate,
    required String whatsAppNumber,
     required String cityCenter,
    required String previousExperience,
    required String education,

  }) async {
    Response? response = await DioHelper.postData(
      url: EndPoints.editProfile,
      data: {
        'name': name,
        'phone': phone,
        'whatsapp_number': whatsAppNumber,
        'the_job': job,
        'the_address': address,
        'governorate': governorate,
        'city_center': cityCenter,
        'previous_experience': previousExperience,
        'gender': PreferencesHelper.getUserModel?.user?.gender,
        'education':PreferencesHelper.getUserModel?.user?.education,
        'email':email,
      },
    );
    return response ;
  }
}
