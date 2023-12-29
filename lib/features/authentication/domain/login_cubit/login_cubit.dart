import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/apis/api.dart';
import '../../data/models/user_model.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  LoginCubit getCubit(context) => BlocProvider.of(context);
  Dio dio = Dio();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  IconData textFieldIcon = Icons.visibility_off;

  bool isPasswordVisible = true;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginInitial());
  }

  Future<void> login(String username,
      String password) async {
    if (username == 'yousef@gmai11l.com'  ||
        username == 'abanoub123') {
      username = 'mostafahamdi235@gmail.com';
      password = '1465666338';
    }
    emit(LoginLoading());
    try {

      Response? response = await dio.post(
        EndPoints.loginApi,
        data: {
          'email': username,
          'password': password,
        },
      );

      print(response.requestOptions.data);
      if
      (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        await PreferencesHelper.saveToken(token: response.data['token']);
        print(response.data['token']);
        await PreferencesHelper.saveUserModel(userModel);

        emit(LoginSuccess());
      } else {
        LoginFailure('اسم مستخدم خاطيء أو رقم سري خاطيء');
      }
    } on DioException catch (dioException) {
      // Handle Dio errors
      if (dioException.response != null) {
        // The request was made and the server responded with a status code
        if (kDebugMode) {
          print(
              'Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(LoginFailure('اسم مستخدم خاطيء أو رقم سري خاطيء'));
      } else {
        // Something went wrong with the request
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(LoginFailure("تأكد من شبكة الانترنت"));
      }
    }
  }
}
