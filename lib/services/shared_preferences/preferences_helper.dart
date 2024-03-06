import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:life_makers/features/authentication/data/models/phone_user_mode.dart';
import 'package:life_makers/features/authentication/presentation/pages/login_screen.dart';
import 'package:life_makers/features/home_page/presentation/pages/drawer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/authentication/data/models/user_model.dart';

class PreferencesHelper {
  static SharedPreferences? preferences;

  static void init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken({required String token}) async {
    await preferences?.setString("token", token);
  }

  static String? getToken() {
    return preferences?.getString("token");
  }

  static Future<void> saveIsVisitor({required bool isVisitor}) async {
    await preferences?.setBool("isVisitor", isVisitor);
  }

  static bool get getIsVisitor {
    return preferences?.getBool("isVisitor") ?? false;
  }

  static Future<void> saveUserModel(UserModel userModel) async {
    await preferences?.setString('userModel', json.encode(userModel));
  }

  static Future<void> savePhoneUserModel(PhoneUserModel phoneUserModel) async {
    await preferences?.setString('phoneUserModel', json.encode(phoneUserModel));
  }

  static UserModel? get getUserModel {
    if (preferences?.getString('userModel') != null) {
      return UserModel.fromJson(
          json.decode('${preferences?.getString('userModel')}'));
    }
    return null;
  }

  static PhoneUserModel? get getPhoneUserModel {
    if (preferences?.getString('phoneUserModel') != null) {
      return PhoneUserModel.fromJson(
          json.decode('${preferences?.getString('phoneUserModel')}'));
    }
    return null;
  }

  static String get getName {
    UserModel? userModel = UserModel.fromJson(
        json.decode('${preferences?.getString('userModel')}'));
    return userModel.user?.name ?? '';
  }

  static void logOut() {
    preferences?.remove('token');
    preferences?.remove('userModel');
  }

  static Widget get applicationFirstPage {

    return PreferencesHelper.getToken() != null ? DrawerPage() : const LoginScreen();
  }
}
