import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/data/apis/api.dart';
import 'package:life_makers/features/authentication/data/models/area_model.dart';
import 'package:life_makers/features/authentication/data/models/city_model.dart';
import 'package:life_makers/features/authentication/data/models/current_joined_campaigns_and_opp.dart';
import 'package:life_makers/features/authentication/data/models/notification_model.dart';
import 'package:life_makers/features/authentication/data/models/phone_user_mode.dart';
import 'package:life_makers/features/authentication/data/models/register_error_model.dart';
import 'package:life_makers/features/authentication/data/models/user_model.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  SignUpCubit getCubit(context) => BlocProvider.of(context);
  Dio dio = Dio();
  final _prefs = SharedPreferences.getInstance();
  List<String> finalData = [];
  IconData textFieldIcon = Icons.visibility_off;
  CityModel? cityModel;
  AreaModel? areaModel;
  bool phoneLength = true;
  List<City> citiesList = [];
  List<Areas> areasList = [];
  int? cityId;
  NotificationModel? notificationModel;
  CurrentJoinedCampaignsAndOpp? currentJoinedCampaignsAndOpp;
  final TextEditingController phoneResetPasswordController =
      TextEditingController();
  String? selectedCityName;

  City? selectedCity;
  Areas? selectedArea;
  final TextEditingController resetPasswordController = TextEditingController();
  final TextEditingController confirmResetPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController controller = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();
  // final TextEditingController cityDropdownController = TextEditingController();
  // final TextEditingController areaDropdownController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController workController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController previousExperienceController =
      TextEditingController();
  bool isConfirmed = false;
  bool otpSent = false;
  bool resend = false;

  void handleSignUp() {
    SignUp(
      nameController.text,
      usernameController.text,
      passwordController.text,
      emailController.text,
      phoneController.text,
      whatsappController.text,
      idNumberController.text,
      workController.text,
      addressController.text,
      selectedCity!.name!,
      selectedArea!.name!,
      previousExperienceController.text,
    );
  }

  void resendOtp() {
    emit(OtpResend());
  }

  void resendOtpCycle() {
    emit(OtpResendCycleState());
  }

  void phoneLengthFalse() {
    phoneLength = false;
  }

  void reset() {
    emit(SignUpInitial());
  }

  void phoneLengthTrue() {
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
      Response? response = await dio.post(
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
        // ignore: body_might_complete_normally_catch_error
      ).catchError((e) {
        emit(SignUpFailure('خطأ في إنشاء الحساب'));
      });

      if (response.statusCode == 200 && response.data['status'] == true) {
        PreferencesHelper.saveIsVisitor(isVisitor: false);
        UserModel userModel = UserModel.fromJson(response.data);
        await PreferencesHelper.saveToken(token: response.data['token']);
        await PreferencesHelper.saveUserModel(userModel);

        await _prefs.then((prefs) => prefs.setBool('isAuthenticated', true));
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure("Invalid credentials"));

        RegisterErrorModel? errorModel =
            RegisterErrorModel.fromJson(response.data);
        CustomSnackBars.showErrorToast(
            title:
                '${errorModel.errors?.first ?? "خطأ في عملية انشاء الحساب"}');
      }
    } catch (e) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(SignUpFailure('تأكد من الانترنت الخاص بك'));
      } else {
        emit(SignUpFailure('خطأ في عملية انشاء الحساب'));
      }
    }
  }

  Future<void> refresh() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await GetUserNotifications();
    } catch (error) {
      if (kDebugMode) {
        print('Error refreshing data: $error');
      }
    }
  }

  Future<void> GetUserNotifications() async {
    emit(NotificationsLoading());
    try {
      Response? response = await dio.get(
        EndPoints.notificationList,
        options: Options(headers: {
          'Authorization': 'Bearer ${PreferencesHelper.getToken()}'
        }),
      );
      if (response.statusCode == 200) {
        notificationModel = NotificationModel.fromJson(response.data);
        emit(NotificationSuccessfully());
      } else {
        NotificationFailure('حدث خطأ حاول مجددا');
      }
    } on DioException catch (dioException) {
      if (dioException.response != null) {
        if (kDebugMode) {
          print(
              'Server responded with status code: ${dioException.response!.statusCode}');
        }
        emit(NotificationFailure('حدث خطأ حاول مجددا'));
      } else {
        if (kDebugMode) {
          print('Dio exception: ${dioException.message}');
        }
        emit(NotificationFailure("Dio exception: ${dioException.message}"));
      }
    }
  }

  Future<void> GetCurrentJoinedCampaignsAndOpp() async {
    emit(CurrCampAndOppLoading());

    Response? response = await dio.get(
      EndPoints.currentCampaignsAndOpportunities,
      options: Options(
          headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'}),
    );
    if (response.statusCode == 200) {
      currentJoinedCampaignsAndOpp =
          CurrentJoinedCampaignsAndOpp.fromJson(response.data);
      emit(CurrCampAndOppSuccess());
    } else {
      CurrCampAndOppFailure('حدث خطأ حاول مجددا');
    }
  }

  Future<void> OtpCheck(String phone) async {
    emit(OtpSendLoading());
    try {
      final response = await dio.post(
        EndPoints.sendOtpCode,
        data: {'phone': phone},
      );
      if (response.statusCode == 200) {
        emit(OtpSendSuccess());
        print('aaaaaaaaaaaaaaaaaa');
      } else {
        emit(OtpSendFailure("Invalid credentials"));
      }
    } catch (e) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(OtpSendFailure('تأكد من الانترنت الخاص بك'));
      } else {
        emit(OtpSendFailure("حدث خطأ في زمز التحقق"));
      }
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
        await PreferencesHelper.savePhoneUserModel(phoneUserModel);
        emit(otpResetPasswordSentSuccess());
      } else {
        emit(otpResetPasswordSentFailure("هذا الرقم غير مسجل"));
      }
    } catch (e) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(otpResetPasswordSentFailure('تأكد من الانترنت الخاص بك'));
      } else {
        emit(otpResetPasswordSentFailure("هذا الرقم غير مسجل"));
      }
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
        print('asssssssssssssssssssssssssssssssssssssss');
      }
      if (response.statusCode == 401) {
        emit(OtpSubmitFailure('Invalid Credentials'));
      } else {
        emit(OtpSubmitFailure("Invalid credentials"));
      }
    } catch (e) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(OtpSubmitFailure('تأكد من الانترنت الخاص بك'));
      } else {
        emit(OtpSubmitFailure("رقم الهاتف غير مسجل.. حاول رقم آخر"));
      }
    }
  }

  Future<void> OtpRestPasswordSubmit(String code, String user_id) async {
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
      } else {
        emit(otpResetPasswordSubmitFailure("Invalid credentials"));
      }
    } catch (e) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(otpResetPasswordSubmitFailure('تأكد من الانترنت الخاص بك'));
      } else {
        emit(otpResetPasswordSubmitFailure(
            "رقم الهاتف غير مسجل.. حاول رقم آخر"));
      }
    }
  }

  Future<void> ChangePassword(
      String password, String password_confirmation) async {
    String? token = PreferencesHelper.getToken();
    if (kDebugMode) {
      print(token);
    }
    emit(changePasswordLoading());
    try {
      final response = await dio.post(
        EndPoints.changePasswordFromReset,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
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
      } else {
        emit(changePasswordFailure("Invalid credentials"));
      }
    } catch (e) {
      // if (kDebugMode) {
      //   print('Error during Sign Up: $e');
      // }
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(changePasswordFailure('تأكد من الانترنت الخاص بك'));
      } else {
        emit(changePasswordFailure("Phone Number is taken.. Try Another one"));
      }
    }
  }

  Future<void> ChangePasswordAfterLogin(
      String oldPassword, String password, String password_confirmation) async {
    String? token = PreferencesHelper.getToken();
    if (kDebugMode) {
      print(token);
    }
    emit(changePasswordAfterLoginLoading());
    final response = await dio.post(
      EndPoints.changePasswordAfterLogin,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
      data: {
        'old_password': oldPassword,
        'password': password,
        'password_confirmation': password_confirmation,
      },
    );
    if (response.statusCode == 200 && response.data['status'] == true) {
      emit(changePasswordAfterLoginSuccess());
    } else {
      emit(changePasswordAfterLoginFailure('كلمة المرور القديمة غير صحيحة'));
    }
  }

  Future<void> fetchCityData() async {
    emit(cityListLoading());
    try {
      final response = await Dio().get(EndPoints.cityApi);
      if (response.statusCode == 200) {
        cityModel = CityModel.fromJson(response.data);
        List<dynamic> cityData = response.data['cities'];
        citiesList = cityData.map((json) => City.fromJson(json)).toList();
        emit(cityListSuccessfully());
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      emit(cityListFailure('Error: $e'));
    }
  }

  Future<void> fetchAreaData() async {
    emit(areaListLoading());
    try {
      final response = await Dio().get(
          'https://life-makers.digifly-eg.com/api/areas/${selectedCity?.id}');
      if (response.statusCode == 200) {
        areaModel = AreaModel.fromJson(response.data);
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
