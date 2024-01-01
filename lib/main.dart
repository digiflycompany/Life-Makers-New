import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/authentication/domain/card_cubit/cards_cubit.dart';
import 'package:life_makers/features/authentication/domain/login_cubit/login_cubit.dart';
import 'package:life_makers/features/authentication/domain/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/edit_account/cubit/edit_account_cubit.dart';
import 'package:life_makers/features/home_page/domain/menu_page_cubit/menu_page_cubit.dart';
import 'package:life_makers/features/splash_screen/presentation/cubit/splash_cubit.dart';
import 'package:life_makers/features/splash_screen/presentation/widgets/splash_screen.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/one_day_activity_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/remote_tasks_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/suggestion_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_thanks_cubit.dart';
import 'package:life_makers/services/app.service.dart';
import 'package:life_makers/services/dio_helper/dio_helper.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/utils/app-string.dart';
import 'features/campaign_details/cubit/all_campaigns_cubit.dart';
import 'features/campaign_details/cubit/join_campaign_cubit.dart';
import 'features/elections/cubit/all_candidates_cubit.dart';
import 'features/elections/cubit/vote_candidate_cubit.dart';
import 'features/home_page/cubit/emergency_campaigns_cubit.dart';
import 'features/home_page/cubit/home_calender_cubit.dart';
import 'features/non_seasonal_campaigns/cubit/non_seasonal_campaigns_cubit.dart';
import 'features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    DioHelper.init();
    PreferencesHelper.init();

    await Firebase.initializeApp();
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://example@sentry.io/650cb00a9b4a6cb9629977442fd2eeba8fec6bdf3228e4ac81ec9e29e367c0d9';
      },
      appRunner: () => runApp(MyApp()),
    );
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<JoinCampaignCubit>(
          create: (BuildContext context) => JoinCampaignCubit(),
        ),
        BlocProvider<EditAccountCubit>(
          create: (BuildContext context) => EditAccountCubit(),
        ),
        BlocProvider<EmergencyCampaignsCubit>(
          create: (BuildContext context) => EmergencyCampaignsCubit(),
        ),
        BlocProvider<AllCandidatesCubit>(
          create: (BuildContext context) => AllCandidatesCubit(),
        ),
        BlocProvider<SignUpCubit>(
          create: (BuildContext context) => SignUpCubit(),
        ),
        BlocProvider<NonSeasonalCampaignsCubit>(
          create: (BuildContext context) => NonSeasonalCampaignsCubit(),
        ),
        BlocProvider<VoteCandidateCubit>(
          create: (BuildContext context) => VoteCandidateCubit(),
        ),
        BlocProvider<MenuCubit>(
          create: (BuildContext context) => MenuCubit(),
        ),
        BlocProvider<SeasonalCampaignsCubit>(
          create: (BuildContext context) => SeasonalCampaignsCubit(),
        ),
        BlocProvider<VolunteerCubit>(
          create: (BuildContext context) => VolunteerCubit(),
        ),
        BlocProvider<OneDayActivityCubit>(
          create: (BuildContext context) => OneDayActivityCubit(),
        ),
        BlocProvider<RemoteTasksCubit>(
          create: (BuildContext context) => RemoteTasksCubit(),
        ),
        BlocProvider<AllCampaignsCubit>(
          create: (BuildContext context) => AllCampaignsCubit(),
        ),
        BlocProvider<SuggestionCubit>(
          create: (BuildContext context) => SuggestionCubit(),
        ),
        BlocProvider<VolunteerThanksCubit>(
          create: (BuildContext context) => VolunteerThanksCubit(),
        ),
        BlocProvider<HomeCalenderCubit>(
          create: (BuildContext context) => HomeCalenderCubit(),
        ),
        BlocProvider<SplashCubit>(
          create: (BuildContext context) => SplashCubit(),
        ),
        BlocProvider<CardCubit>(
          create: (BuildContext context) => CardCubit(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          navigatorObservers: [
            SentryNavigatorObserver(),
          ],
          title: AppStrings.lifeMaker,
          debugShowCheckedModeBanner: false,
          navigatorKey: AppService().navigatorKey,
          home: SplashScreen(),
          // home: EditAccountScreen(),
        ),
      ),
    );
  }
}
