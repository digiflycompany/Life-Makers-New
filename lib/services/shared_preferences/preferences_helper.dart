import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/data/models/phone_user_mode.dart';
import 'package:life_makers/features/authentication/presentation/pages/login_screen.dart';
import 'package:life_makers/features/home_page/presentation/pages/drawer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/authentication/data/models/user_model.dart';

class PreferencesHelper {
  static SharedPreferences? preferences;

  static Future<void> init() async {
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
    await preferences?.setString('userModel', json.encode(userModel.toJson()));
  }

  static Future<void> savePhoneUserModel(PhoneUserModel phoneUserModel) async {
    await preferences?.setString('phoneUserModel', json.encode(phoneUserModel.toJson()));
  }

  static UserModel? get getUserModel {
    if (preferences?.getString('userModel') != null) {
      return UserModel.fromJson(json.decode(preferences!.getString('userModel')!));
    }
    return null;
  }

  static PhoneUserModel? get getPhoneUserModel {
    if (preferences?.getString('phoneUserModel') != null) {
      return PhoneUserModel.fromJson(json.decode(preferences!.getString('phoneUserModel')!));
    }
    return null;
  }

  static String get getName {
    UserModel? userModel = getUserModel;
    return userModel?.user?.name ?? '';
  }

  static int get getUserPoints {
    UserModel? userModel = getUserModel;
    return userModel?.user?.points ?? 0;
  }

  static double normalizePoints(int points, {int maxPoints = 1000}) {
    return (points / maxPoints).clamp(0.0, 1.0);
  }

  static void logOut() {
    preferences?.remove('token');
    preferences?.remove('userModel');
    Routes.loginPageRoute.moveToCurrentRouteAndRemoveAll;
  }

  static Future<Widget> applicationFirstPage() async {
    return await getToken() != null ? DrawerPage() : LoginScreen();
  }

  static Future<bool> isLoggedIn() async {
    return getToken() != null;
  }

}
