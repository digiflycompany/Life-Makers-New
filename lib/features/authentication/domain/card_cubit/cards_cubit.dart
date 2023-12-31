import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/authentication/domain/card_cubit/card_states.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';
import '../../data/apis/api.dart';
import '../../data/models/current_joined_campaigns_and_opp.dart';

class CardCubit extends Cubit<CardStates> {
  CardCubit() : super(CardInitial());
  CardCubit getCubit(context) => BlocProvider.of(context);
  Dio dio = Dio();
  CurrentJoinedCampaignsAndOpp? currentJoinedCampaignsAndOpp;

  Future<void> GetCurrentJoinedCampaignsAndOpp() async {
    emit(CardLoading());

    Response? response = await dio.get(
      EndPoints.currentCampaignsAndOpportunities,
      options: Options(headers: {
        'Authorization': 'Bearer ${PreferencesHelper.getToken()}'
      }),
    );
    if (response.statusCode == 200) {
      currentJoinedCampaignsAndOpp = CurrentJoinedCampaignsAndOpp.fromJson(response.data);
      emit(CardSuccess());
    } else {
      CardFailure('حدث خطأ حاول مجددا');
    }

  }


}
