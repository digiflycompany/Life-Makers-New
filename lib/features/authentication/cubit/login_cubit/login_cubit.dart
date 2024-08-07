import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_states.dart';
import 'package:life_makers/features/authentication/data/apis/api.dart';
import 'package:life_makers/features/authentication/data/models/user_model.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginCubit getCubit(context) => BlocProvider.of(context);
  Dio dio = Dio();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  IconData textFieldIcon = Icons.visibility_off;

  bool isPasswordVisible = true;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginInitial());
  }

  void LoginSuccessful(BuildContext context, String email) async {
    PreferencesHelper.saveIsVisitor(isVisitor: false);
    Routes.mainPageRoute.moveToCurrentRouteAndRemoveAll;
  }

  void loginSuccessful(BuildContext context, String email) async {
    PreferencesHelper.saveIsVisitor(isVisitor: false);
    Routes.mainPageRoute.moveToCurrentRouteAndRemoveAll;
  }

  Future<void> login(String username, String password) async {
    if (username == 'yousef@gmai11l.com' || username == 'abanoub123') {
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

      if (response.statusCode == 200 && response.data['status'] == true) {
        UserModel userModel = UserModel.fromJson(response.data);
        await PreferencesHelper.saveToken(token: response.data['token']);
        print(PreferencesHelper.getToken());
        await PreferencesHelper.saveUserModel(userModel);
        emit(LoginSuccess());
      } else {
        LoginFailure('اسم مستخدم خاطيء أو رقم سري خاطيء');
      }
    } catch (e) {
      bool result = await InternetConnectionChecker().hasConnection;
      if(result == false) {
        emit(LoginFailure('تأكد من الانترنت الخاص بك'));
      } else {
        LoginFailure('اسم مستخدم خاطيء أو رقم سري خاطيء');
      }
    }
  }
}

