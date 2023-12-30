import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/member_campaign_details.dart';
import 'package:life_makers/features/campaign_details/repo/join_campaign_repository.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/widgets/custom_snack_bar.dart';
import '../../home_page/presentation/pages/drawer_page.dart';

class JoinCampaignCubit extends Cubit<CubitBaseState> {
  JoinCampaignCubit() : super(CubitBaseState.initial);
  CampaignRepository? joinCampaignRepository = CampaignRepository();
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
}
