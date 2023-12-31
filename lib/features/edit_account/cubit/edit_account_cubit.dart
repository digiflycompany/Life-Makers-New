
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_makers/features/edit_account/repo/edit_account_repository.dart';
import 'package:life_makers/features/home_page/presentation/pages/drawer_page.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';

import '../../authentication/data/models/user_model.dart';

class EditAccountCubit extends Cubit<CubitBaseState> {
  EditAccountCubit() : super(CubitBaseState.initial);

  EditAccountRepository? editAccountRepository = EditAccountRepository();

  Future<void> editAccountData({
    required String name,
    required String email,
    required XFile? file,
    required String password,
    required String phone,
    required String gender,
    required String address,
    required String job,
    required String governorate,
    required String whatsAppNumber,
    required BuildContext context,
    required String cityCenter,
    required String previousExperience,
    required String education,
  }) async {
    emit(CubitBaseState.loading);
    Response? response = await editAccountRepository?.editAccountData(
      address: address,
      file: file,
      cityCenter: cityCenter,
      email: email,
      governorate: governorate,
      job: job,
      name: name,
      phone: phone,
      previousExperience: previousExperience,
      whatsAppNumber: whatsAppNumber,
      education: education,
    );

    if (kDebugMode) {
      print('Edit profile response ${response?.data}');
      print('Edit profile data request ${response?.requestOptions.data}');
    }
    if (response?.statusCode == 200 && response?.data['status'] == true) {
      emit(CubitBaseState.done);

      Fluttertoast.showToast(msg: '${response?.data['message']}');

      PreferencesHelper.saveUserModel(UserModel.fromJson(response?.data));

      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 100),
              child: DrawerPage()),
          (vale) => true);
    } else {
      emit(CubitBaseState.error);
      Fluttertoast.showToast(msg: 'خطأ في تعديل الحساب');
    }
  }
}
