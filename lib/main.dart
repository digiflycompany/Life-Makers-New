import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app.service.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/app_theme.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/cards_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/edit_account/cubit/edit_account_cubit.dart';
import 'package:life_makers/features/home_page/cubit/menu_page_cubit/menu_page_cubit.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/one_day_activity_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/remote_tasks_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/suggestion_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_thanks_cubit.dart';
import 'package:life_makers/l10n/l10n.dart';
import 'package:life_makers/services/dio_helper/dio_helper.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

import 'core/utils/app-string.dart';
import 'features/campaign_details/cubit/all_campaigns_cubit.dart';
import 'features/campaign_details/cubit/join_campaign_cubit.dart';
import 'features/elections/cubit/all_candidates_cubit.dart';
import 'features/elections/cubit/vote_candidate_cubit.dart';
import 'features/home_page/cubit/emergency_campaigns_cubit.dart';
import 'features/home_page/cubit/home_calender_cubit.dart';
import 'features/non_seasonal_campaigns/cubit/non_seasonal_campaigns_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  PreferencesHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<SignUpCubit>(
                create: (BuildContext context) => SignUpCubit(),
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
              BlocProvider<CardCubit>(
                create: (BuildContext context) => CardCubit(),
              ),
            ],
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: MaterialApp(
                theme: AppTheme.lightTheme,
                title: AppStrings.lifeMaker,
                supportedLocales: L10n.all,
                locale: const Locale('ar'),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                navigatorKey: AppService().navigatorKey,
                onGenerateRoute: RouteGenerator.getRoute,
              ),
            ),
          );
        });
  }
}
