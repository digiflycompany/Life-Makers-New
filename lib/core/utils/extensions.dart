import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/size-utils.dart';
import '../../config/routes/app_routes_helper.dart';


extension StringExtension on String {
  String get removeSpaces => replaceAll(' ', '');


  dynamic get fromStringToJson => jsonDecode(this);
  String get capitalize => toUpperCase();
  String addAtStart(String start) => "$start$this";
  bool isLengthEqual(int length) => this.length == length;
  int get toInt => int.parse(this);
  // String tr() {
  //   return AppLocalizations.of(AppService().getContext)!.translate(this) ?? this;
  // }
  //String get trans => this.tr();
  /// Returns true if given String is null or isEmpty
  bool get isEmptyOrNull => (isEmpty) || (this == 'null');
  String validate({String value = ''}) {
    if (isEmptyOrNull) {
      return value;
    } else {
      return this;
    }
  }
  String? get validatePassword {
    if (isEmpty || trim().isEmpty || length < 6) {
     // return AppStrings.passwordError.tr();
    }
    return null;
  }
  String? get validateUserName{
    if (isEmpty) {
    //  return AppStrings.userNameError.tr();
    }
    return null;
  }
  // bool get _isEmail {
  //   const String emailRegex =
  //       '^([\\w\\d\\-\\+]+)(\\+[\\w\\d\\-\\+%]+)*([\\w\\-]+\\.){1,5}(([A-Za-z]){2,30}|xn--[A-Za-z0-9]{1,26})\$';
  //   var regExp = RegExp(emailRegex);
  //   return regExp.hasMatch(this);
  // }

  // String? validateEmail() {
  //   if (isEmpty
  //       || !_isEmail
  //   ) {
  //     return AppStrings.emailError.tr();
  //   }
  //   return null;
  // }
  // String? get validateOtp {
  //   if (isEmpty || trim().isEmpty || length < 4) {
  //     return AppStrings.otpCodeError.tr();
  //   }
  //   return null;
  // }
  // String? validatePhone({String? name}) {
  //   return Inspection(inspectionLocale: AppLocalizations.of(AppService().getContext)!.locale.languageCode)
  //       .inspect(this, 'required|numeric|min:10|max:16', name: name, message: AppStrings.phoneError.tr()
  //     // locale: translator.activeLocale.languageCode,
  //   );
  // }

  bool isJson() {
    try {
      json.decode(validate());
    } catch (e) {
      return false;
    }
    return true;
  }
  isEqualTo(value)=>this==value;
  isNotEqualTo(value)=>this!=value;
  get getBack => pop();

  get moveToAndRemoveCurrent => pushRoute(this, isToReplace: true);

  get moveTo => pushRoute(this);

  get pushAndRemoveAllUntil => pushRoute(this, isNewTask: true);

  pushReplacementWithData(Map<String, dynamic>? arguments) => pushRoute(this, isToReplace: true, arguments: arguments);

  pushWithData(Map<String, dynamic>? arguments) => pushRoute(this, arguments: arguments);

  pushAndRemoveAllWithDataUntil(Map<String, dynamic>? arguments) => pushRoute(this, isNewTask: true, arguments: arguments);
  popScreen([Object? object]) => pop(object);
  popScreenWithArgument([Object? object]) => pop(object);

  //get moveToCurrrentRouteAndRemoveAllExceptHome => pushRoute(this, isNewTask: true, exceptRoute: Routes.home);
  moveToCurrrentRouteAndRemoveAllExceptThisRoute() => pushRoute(this, isNewTask: true, exceptRoute: this);
  get moveToCurrrentRouteAndRemoveAll => pushRoute(this, isNewTask: true);
  get pushReplacement => pushRoute(this, isToReplace: true);
  get push => pushRoute(this);
}

extension CutomMethodsOnNullObject on Object? {
  String get fromJsonToString => jsonEncode(this);
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isNotNullAndIsFalse => this != null && this == false;
  bool get isNotNullAndIsTrue => this != null && this == true;
  bool get isNullOrIsFalse => this == null || this == true;
  bool get isNotNullOrFalse => this != null || this != true;
  bool get isNotFalse => this != false;
  bool get isNotTrue => this != true;
  bool get isTrue => this == true;
  bool get isFalse => this == false;
}
extension CutomMethodsOnObject on Object {
  isEqualTo(value)=>this==value;
  isNotEqualTo(value)=>this!=value;
}

extension StringNullExtension on String? {
  String get validate => this == null ? '' : this!;
  int get toInt => validate.isEmpty ? 0 : int.parse(this!);
  bool get isNotNull => this != null;
  bool get isNull => this == null;
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
  // String get tr => isNotNull ? AppLocalizations.tr(context)anslate(this!)! : "";
}

extension IntExtension on int {
  Duration get milliseconds => Duration(milliseconds: this);
  bool isSuccessful() => this >= 200 && this <= 206;
  double get h => getVerticalSize(toDouble());
  double get w => getHorizontalSize(toDouble());
  double get r => getVerticalSize(toDouble());

  SizedBox get vs => SizedBox(height: h);
  SizedBox get hs => SizedBox(width: w);
}

extension BullBoolExtension on bool? {
  /* null false , false false */
  bool get validate => this == null ? false : this!;
}
extension BoolExtension on bool {
  /* null false , false false */
  bool get isFalse=>this==false;
  bool get isTrue=>this==true;
}

extension ListExtension on List<dynamic>? {
  List<dynamic> get validate => this == null ? [] : this!;
}

/* json decode and encode*/
extension MapExtension on Map<String, dynamic> {}

extension DateTimeExtension on DateTime? {
  /*validate*/
  /* string to date time */
  /* formate */
}




extension DynamicExtension on dynamic {
  Map<String, dynamic> get json => jsonDecode(this);
  isEqualTo(value)=>this==value;
  isNotEqualTo(value)=>this!=value;
}

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get topPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}

extension DoubleExtension on double {
  double get h => getVerticalSize(this);
  double get w => getHorizontalSize(this);
  double get r => getVerticalSize(this);

  SizedBox get vs => SizedBox(height:h);
  SizedBox get hs => SizedBox(width: w);
// double get w=>getSize(this);
}
