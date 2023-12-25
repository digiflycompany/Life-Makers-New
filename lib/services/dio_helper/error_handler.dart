import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/custom_snack_bar.dart';
import '../shared_preferences/preferences_helper.dart';


void responseErrorHandler({required BuildContext context, Response? response}) {
  CustomSnackBars.showErrorToast(
      title: '${response?.data?['msg']}');
}
void errorHandler(
    {required BuildContext context,
    Response? response,
    bool? showTopSnackBar}) {
  if (response?.statusCode == 400) {
    CustomSnackBars.showErrorToast(
        title: response?.statusMessage ?? 'Bad request error');
  } else if (response?.statusCode == 500) {
    CustomSnackBars.showErrorToast(title: 'خطأ في السيرفر');
  } else if (response?.statusCode == 401) {
    PreferencesHelper.preferences?.remove('token');
    AwesomeDialog(
            context: context,
            title: "Authentiation Error",
            desc: 'قم بتسجيل الدخول مجددا',
            dialogType: DialogType.error,
            btnOkOnPress: () {})
        .show();
  } else if (response?.statusCode == 404) {
    CustomSnackBars.showErrorToast(title: 'notFoundError');
  }
}
