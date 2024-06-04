import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/cards_cubit.dart';
import 'package:life_makers/features/home_page/cubit/emergency_campaigns_cubit.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/home_app_bar.dart';
import 'package:life_makers/features/home_page/cubit/home_calender_cubit.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/home_calendar.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/urgent_campaigns.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/user_details_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late EmergencyCampaignsCubit emergencyCampaignsCubit;
  late HomeCalenderCubit homeCalenderCubit;
  late CardCubit cardCubit;
  @override
  void initState() {
    emergencyCampaignsCubit = context.read<EmergencyCampaignsCubit>();
    homeCalenderCubit = context.read<HomeCalenderCubit>();
    emergencyCampaignsCubit.getEmergencyCampaignsData();
    homeCalenderCubit.getHomeCalender();
    cardCubit = context.read<CardCubit>();
    cardCubit.GetCurrentJoinedCampaignsAndOpp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor3,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity,50.h),
            child: HomeAppBar()),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const Column(
            children: [
               UserDetailsCard(),
               UrgentCampaigns(),
               HomeCalendar(),
            ],
          ),
        ),
      ),
    );
  }
}
