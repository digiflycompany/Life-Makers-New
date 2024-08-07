import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomSnackBars {
  static void showSuccessToast({required String title}) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  static void showRegularToast({required String title}) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
  static void showErrorToast({required String title}) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
        msg: '$title',

        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,

        fontSize: 16.0);
  }

  static void showInfoSnackBar({
    required String title,
  }) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: title);
  }
}
