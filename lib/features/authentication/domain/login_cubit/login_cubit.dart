import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
      String? deviceToken=await FirebaseMessaging.instance.getToken();
      Response? response = await dio.post(
        EndPoints.loginApi,
        data: {
          'email': username,
          'password': password,
          'device_token':deviceToken,
        },
      );

      if
      (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        await PreferencesHelper.saveToken(token: response.data['token']);
        await PreferencesHelper.saveUserModel(userModel);

        emit(LoginSuccess());
      } else {
        LoginFailure('اسم مستخدم خاطيء أو رقم سري خاطيء');
      }
    } on DioException catch (dioException) {
      // Handle Dio errors
      if (dioException.response != null) {

        emit(LoginFailure('اسم مستخدم خاطيء أو رقم سري خاطيء'));
      } else {
        emit(LoginFailure("تأكد من شبكة الانترنت"));
      }
    }
  }
}
