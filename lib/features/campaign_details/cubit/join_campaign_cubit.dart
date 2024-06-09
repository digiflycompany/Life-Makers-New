import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/member_campaign_details.dart';
import 'package:life_makers/features/campaign_details/repo/join_campaign_repository.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/widgets/custom_snack_bar.dart';
import '../../authentication/data/apis/api.dart';
import '../../home_page/presentation/pages/drawer_page.dart';

class JoinCampaignCubit extends Cubit<CubitBaseState> {
  JoinCampaignCubit() : super(CubitBaseState.initial);
  CampaignRepository? joinCampaignRepository = CampaignRepository();
  PlatformFile? finalFile;
  PlatformFile? finalFile2;
  bool checkedIn = false;
  bool checkedOut = false;
  bool image1Uploaded=false;
  bool image2Uploaded=false;
  bool imagesUploadedToServer=false;
  Dio dio = Dio();

  Future<void> pickProfileImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        finalFile = file;
        emit(CubitBaseState.profileImageSuccess);
        image1Uploaded=true;
      } else {
        emit(CubitBaseState.profileImageFailure);
      }
    } catch (e) {
      emit(CubitBaseState.profileImageFailure);
    }
  }

  Future<void> pickUserInCampaignImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        finalFile2 = file;
        emit(CubitBaseState.userInCampaignImageSuccess);
        image2Uploaded=true;
      } else {
        emit(CubitBaseState.userInCampaignImageFailure);
      }
    } catch (e) {
      emit(CubitBaseState.userInCampaignImageFailure);
    }
  }

  Future<void> uploadFile({PlatformFile? file, PlatformFile? file2, String? campaignId}) async {
    imagesUploadedToServer=true;
    try {
      String fileName = file!.path!.split('/').last;
      String fileName2 = file2!.path!.split('/').last;
      // var data = FormData.fromMap({
      //   'files': [
      //     await MultipartFile.fromFile(file.path!, filename: fileName),
      //     await MultipartFile.fromFile(file2.path!, filename: fileName2),
      //   ],
      //   'campaign_id': campaignId
      // });
      FormData formData = FormData.fromMap({
        'photo[0]':await MultipartFile.fromFile(file.path!,filename: fileName),
        'photo[1]':await MultipartFile.fromFile(file2.path!,filename: fileName2),
        'campaign_id': campaignId,
      });
      //formData.fields.add(MapEntry('campaign_id', campaignId!));

      Response response = await dio.post(
          EndPoints.campaignCheckGallery,
          data: formData,
          options: Options(headers: {'Authorization': 'Bearer ${PreferencesHelper.getToken()}'})
      );
      if(response.isNull){
        emit(CubitBaseState.imagesLoading);
      }
      if (response.statusCode == 200) {
        emit(CubitBaseState.imagesSuccess);
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        // imagesUploadedToServer=true;
      } else {
        emit(CubitBaseState.imagesFailure);
        print('Failedddddddddddddddddddddddddddddddddddddddddd');
      }
    } catch (e) {
      emit(CubitBaseState.imagesFailure);
      print(e.toString());
      print('eroooooooooooooooooooooooooooooooooooooooooooooor');
    }
  }

  Future<void> submitPhoto(String? campaignId) async {
    await uploadFile(file: finalFile, file2: finalFile2, campaignId: campaignId);
  }

  Future<void> joinCampaign({
    required int taskId,
    required BuildContext context,
  }) async {
    emit(CubitBaseState.loading);
    Response? response =
        await joinCampaignRepository?.requestJoinCampaign(taskId: taskId);

    if (kDebugMode) {
      print('******JOIN CAMPAIGN ******');
      print(response?.statusMessage);
      print(response?.statusCode);
      print(response?.data);
    }

    if (response?.statusCode == 200 && response?.data['status']==true) {
     // CustomSnackBars.showSuccessToast(title: '${response?.data['msg']}');
      emit(CubitBaseState.doneJoinCampaign);
    } else {
      emit(CubitBaseState.error);
      CustomSnackBars.showErrorToast(title: '${response?.data['msg']}');
    }
  }
  Future<void> campaignCheckIn({
    required int campaignId,
    required BuildContext context,
  }) async {
    emit(CubitBaseState.loading);
    Response? response =
    await joinCampaignRepository?.campaignCheckIn(campaignId: campaignId);

    if (kDebugMode) {
      print('******JOIN CAMPAIGN ******');
      print(response?.statusMessage);
      print(response?.statusCode);
      print(response?.data);
    }

    if (response?.statusCode == 200 && response?.data['status']==true) {
      emit(CubitBaseState.campaignCheckedIn);
      checkedIn=true;
    } else {
      emit(CubitBaseState.error);
      CustomSnackBars.showErrorToast(title: '${response?.data['msg']}');
    }
  }

  Future<void> campaignCheckOut({
    required int campaignId,
    required BuildContext context,
  }) async {
    emit(CubitBaseState.loading);
    Response? response =
    await joinCampaignRepository?.campaignCheckOut(campaignId: campaignId);

    if (kDebugMode) {
      print('******JOIN CAMPAIGN ******');
      print(response?.statusMessage);
      print(response?.statusCode);
      print(response?.data);
    }

    if (response?.statusCode == 200 && response?.data['status']==true) {
      emit(CubitBaseState.campaignCheckedOut);
      checkedOut=true;
    } else {
      emit(CubitBaseState.error);
      CustomSnackBars.showErrorToast(title: '${response?.data['msg']}');
    }
  }

  Future<void> sendCampaignSuggestion({
    required int taskId,
    required String suggestion,
    required BuildContext context,
  }) async {
    emit(CubitBaseState.done);
    Response? response = await joinCampaignRepository?.sendCampaignSuggestion(
        taskId: taskId, suggestion: suggestion);

    if (response?.data['status'] == false) {
      emit(CubitBaseState.error);
      Navigator.pop(context);

      CustomSnackBars.showErrorToast(title: '${response?.data['msg']}');
    } else {
      CustomSnackBars.showSuccessToast(title: 'تم ارسال المقترح بنجاح');
      Navigator.pop(context);

      emit(CubitBaseState.done);
      showSuccessPopUp(context);
    }
  }

  Future<void> sendCampaignComplaign({
    required int campaignId,
    required String complaign,
    required BuildContext context,
  }) async {
    emit(CubitBaseState.done);
    Response? response = await joinCampaignRepository?.sendCampaignComplaign(
        taskId: campaignId, complaint: complaign);

    if (response?.data['status'] == false) {
      emit(CubitBaseState.error);
      Navigator.pop(context);

      CustomSnackBars.showErrorToast(title: '${response?.data['msg']}');
    } else {
      CustomSnackBars.showSuccessToast(title: 'تم ارسال الشكوي بنجاح');
      Navigator.pop(context);

      emit(CubitBaseState.done);
      showSuccessPopUp(context);
    }
  }

  Future<void> leaveCampaign({
    required int campaignId,
    required String? leaveReason,
    required BuildContext context,
  }) async {
    emit(CubitBaseState.done);
    Response? response = await joinCampaignRepository?.leaveCampaign(
        taskId: campaignId, leaveReason: leaveReason);

    if (response?.data['status'] == false) {
      emit(CubitBaseState.error);
      Navigator.pop(context);

      CustomSnackBars.showErrorToast(title: '${response?.data['msg']}');
    } else {
      CustomSnackBars.showSuccessToast(title: 'تم المغادرة بنجاح');
      Navigator.pop(context);
      emit(CubitBaseState.done);
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 100),
              child: DrawerPage()),
          (vale) => true);
    }
  }

  void resetState() {
    emit(CubitBaseState.initial);
  }
}
