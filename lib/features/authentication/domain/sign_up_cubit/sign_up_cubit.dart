import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/authentication/data/models/city_model.dart';
import 'package:life_makers/features/authentication/data/models/phone_user_mode.dart';
import 'package:life_makers/features/authentication/domain/sign_up_cubit/sign_up_states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';
import '../../data/apis/api.dart';
import '../../data/models/area_model.dart';
import '../../data/models/user_model.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  SignUpCubit getCubit(context) => BlocProvider.of(context);
  Dio dio = Dio();
  final _prefs = SharedPreferences.getInstance();
  List<String> finalData =[];
  IconData textFieldIcon = Icons.visibility_off;
  CityModel? cityModel;
  AreaModel? areaModel;
  bool phoneLength = true;
  List<Cities> citiesList = [];
  List<Areas> areasList = [];
  int? cityId;

  void resendOtp(){
    emit(OtpResend());
  }

  void resendOtpCycle(){
    emit(OtpResendCycleState());
  }

  void phoneLengthFalse(){
    phoneLength = false;
  }
  void reset(){
    emit(SignUpInitial());
  }
  void phoneLengthTrue(){
    phoneLength = true;
  }

  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(SignUpInitial());
  }
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(SignUpInitial());
  }

  Future<void> SignUp(
      String name,
      String username,
      String password,
      String email,
      String phone,
      String whatsapp_number,
      String id_card_number,
      String the_job,
      String the_address,
      String governorate,
      String city_center,
      String previous_experience,
      ) async {
    emit(SignUpLoading());
    try {
      final response = await dio.post(
        EndPoints.registerApi,
        data: {
          'name': name,
          'username': username,
          'password': password,
          'email': email,
          'phone': phone,
          'whatsapp_number': whatsapp_number,
          'id_card_number': id_card_number,
          'the_job': the_job,
          'the_address': the_address,
          'governorate': governorate,
          'city_center': city_center,
          'previous_experience': previous_experience,
        },
      );
      if (response.statusCode == 200) {
        PreferencesHelper.saveIsVisitor(isVisitor: false);

        UserModel userModel = UserModel.fromJson(response.data);
        await PreferencesHelper.saveToken(token: response.data['token']);
        await  PreferencesHelper.saveUserModel(userModel);
        if (kDebugMode) {
          print(response);
        }
        await _prefs.then((prefs) => prefs.setBool('isAuthenticated', true));
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure("Invalid credentials"));
      }
    } catch (e) {

      if (kDebugMode) {
        print('Error during login: $e');
      }
      emit(SignUpFailure("An error occurred"));
    }
  }

  Future<void> OtpCheck(String phone) async {
    emit(OtpSendLoading());
    try {
      final response = await dio.post(
        EndPoints.sendOtpCode,
        data: {
          'phone': phone,
        },
      );
      if (response.statusCode == 200) {
        // UserModel userModel = UserModel.fromJson(response.data);
        // await PreferencesHelper.saveToken(token: response.data['token']);
        // await  PreferencesHelper.saveUserModel(userModel);
        emit(OtpSendSuccess());
      } else {
        emit(OtpSendFailure("Invalid credentials"));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during signup: $e');
      }
      emit(OtpSendFailure("An error occurred"));
    }
  }
  Future<void> OtpResetPasswordCheck(String phone) async {
    emit(otpResetPasswordSentLoading());
    try {
      Response? response = await dio.post(
        EndPoints.sendResetPasswordOtpCode,
        data: {
          'phone': phone,
        },
      );
      if (response.statusCode == 200) {
        PhoneUserModel phoneUserModel = PhoneUserModel.fromJson(response.data);
        await  PreferencesHelper.savePhoneUserModel(phoneUserModel);
        emit(otpResetPasswordSentSuccess());
      } else {
        emit(otpResetPasswordSentFailure("Invalid credentials"));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during login: $e');
      }
      emit(otpResetPasswordSentFailure("An error occurred"));
    }
  }


  Future<void> OtpSubmit(String code) async {
    emit(OtpSubmitLoading());
    try {
      final response = await dio.post(
        EndPoints.submitOtpCode,
        data: {
          'code': code,
        },
      );
      if (response.statusCode == 200) {
          emit(OtpSubmitSuccess());
      }
      if (response.statusCode == 401) {
        emit(OtpSubmitFailure('Invalid Credentials'));
      }else {
        emit(OtpSubmitFailure("Invalid credentials"));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during Sign Up: $e');
      }
      emit(OtpSubmitFailure("Phone Number is taken.. Try Another one"));
    }
  }


  Future<void> OtpRestPasswordSubmit(String code,String user_id) async {
    emit(otpResetPasswordSubmitLoading());
    try {
      Response response = await dio.post(
        EndPoints.SubmitResetPasswordOtpCode,
        data: {
          'user_id': user_id,
          'code': code,
        },
      );
      if (response.statusCode == 200) {
        await PreferencesHelper.saveToken(token: response.data['token']);
       
        emit(otpResetPasswordSubmitSuccess());
      }
     else {
        emit(otpResetPasswordSubmitFailure("Invalid credentials"));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during Sign Up: $e');
      }
      emit(otpResetPasswordSubmitFailure("Phone Number is taken.. Try Another one"));
    }
  }

  Future<void> ChangePassword(String password,String password_confirmation) async {
    String? token =PreferencesHelper.getToken();
    if (kDebugMode) {
      print(token);
    }
    emit(changePasswordLoading());
    try {

      final response = await dio.post(
        EndPoints.changePasswordFromReset,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        ),
        data: {
          'password': password,
          'password_confirmation': password_confirmation,
        },
      );
      if (response.statusCode == 200) {
        emit(changePasswordSuccess());
      }
      if (response.statusCode == 401) {
        emit(changePasswordFailure('Invalid Credentials'));
      }else {
        emit(changePasswordFailure("Invalid credentials"));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during Sign Up: $e');
      }
      emit(changePasswordFailure("Phone Number is taken.. Try Another one"));
    }
  }

  Future<void> ChangePasswordAfterLogin(String oldPassword, String password,String password_confirmation) async {
    String? token =PreferencesHelper.getToken();
    if (kDebugMode) {
      print(token);
    }
    emit(changePasswordAfterLoginLoading());
    try {

      final response = await dio.post(
        EndPoints.changePasswordAfterLogin,
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            }
        ),
        data: {
          'old_password': oldPassword,
          'password': password,
          'password_confirmation': password_confirmation,
        },
      );
      if (response.statusCode == 200) {
        emit(changePasswordAfterLoginSuccess());
      }
      if (response.statusCode == 401) {
        emit(changePasswordAfterLoginFailure('Invalid Credentials'));
      }else {
        emit(changePasswordAfterLoginFailure("Invalid credentials"));
      }
    } catch (e) {
      if (kDebugMode) {
        print('حدث خطأ أثناء التسجيل حاول مره اخرى');
      }
      emit(changePasswordAfterLoginFailure("Phone Number is taken.. Try Another one"));
    }
  }


  Future <void> fetchCityData() async {
    emit(cityListLoading());
    try {
      final response = await Dio().get(EndPoints.cityApi);
      if (response.statusCode == 200) {
        cityModel = CityModel.fromJson(response.data);
        List<dynamic> cityData = response.data['cities'];
        citiesList = cityData.map((json) => Cities.fromJson(json)).toList();
        emit(cityListSuccessfully());
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      emit(cityListFailure('Error: $e'));
    }
  }

  Future <void> fetchAreaData() async {
    emit(areaListLoading());
    try {
      final response = await Dio().get('https://life-makers.digifly-eg.com/api/areas/$cityId');
      if (response.statusCode == 200) {
        areaModel = AreaModel.fromJson(response.data);
        //final List<dynamic> jsonData = response.data;
        //final List<String> data = jsonData.map((item) => item.toString()).toList();
        //print(data);
        //finalData =data;
        //print(finalData);
        List<dynamic> areaData = response.data['areas'];
        areasList = areaData.map((json) => Areas.fromJson(json)).toList();
        emit(areaListSuccessfully());
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      emit(areaListFailure('Error: $e'));
    }
  }

}
