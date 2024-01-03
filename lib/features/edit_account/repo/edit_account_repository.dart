import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class EditAccountRepository {
  Dio dio = Dio();

  Future<Response?> editAccountData({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String job,
    required String ?governorate,
    required XFile? file,
    required String whatsAppNumber,
    required String? cityCenter,
    required String previousExperience,
    required String education,
  }) async {
    String? fileName;
    if(file!=null)
      {
         fileName = file.path.split('/').last;
      }
    FormData formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'whatsapp_number': whatsAppNumber,
      'the_job': job,
      'the_address': address,
      'governorate': governorate,
      'city_center': cityCenter,
      'previous_experience': previousExperience,
      'gender': PreferencesHelper.getUserModel?.user?.gender,
      'education': PreferencesHelper.getUserModel?.user?.education,
      'email': email,
      "photo": file!=null?await MultipartFile.fromFile(file.path, filename:fileName):null,

    });


    Response response = await dio.post(
      'https://life-makers.digifly-eg.com/api/user-edit',
      options: Options(
          headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'}),
      data: formData,
    );

    if (kDebugMode) {
      print('Edit profile response $response');
    }
    return response;
  }
}
