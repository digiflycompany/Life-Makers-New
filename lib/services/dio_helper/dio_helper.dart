import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../features/authentication/data/apis/api.dart';
import '../shared_preferences/preferences_helper.dart';

class DioHelper {
  static BaseOptions opts = BaseOptions(
    baseUrl: EndPoints.baseUrl,
    receiveDataWhenStatusError: true,
    followRedirects: false,
    validateStatus: (status) {
      return status! <= 500;
    },
  );

  static Dio init() {
    return Dio(opts);
  }

  static Dio? dio = init();

  static Future<Response?> postData(
      {required String url, Map<String, dynamic>? data}) async {
    String? token = PreferencesHelper.getToken();
    try {
      Response? response = await dio?.post(
        url,
        options: Options(headers: {'Authorization': 'Bearer ${token}'}),
        data: data,
      );

      if (kDebugMode) {
        print('STATUS CODE IS ${response?.statusCode}');
        print('STATUS MESSAGE IS ${response?.statusMessage}');
        print('SENT DATA IS ${response?.requestOptions.data}');
        print('RESPONSE IS ${response}');
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('DIO ERROR IS $e');
      }
      return e is DioException ? e.response : null;
    }
  }

  static Future<Response?> getData(
      {required String url, Map<String, dynamic>? queryParameters}) async {
    try {
      String? token = PreferencesHelper.getToken();

      Response? response = await dio?.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token}',
          },
        ),
      );
      if (kDebugMode) {
        print('STATUS CODE IS ${response?.statusCode}');
        print('SENT DATA IS ${response?.requestOptions.data}');
        print('STATUS MESSAGE IS ${response?.statusMessage}');
        print('RESPONSE IS ${response}');
      }
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('DIO ERROR IS $e');
      }
      return e is DioException ? e.response : null;
    }
  }

  static Future<Response?> putData(
      {required String url, required Map<String, dynamic> data}) async {
    try {
      Response? response = await dio?.put(url, data: data);
      return response;
    } catch (e) {
      return e is DioException ? e.response : null;
    }
  }
}
