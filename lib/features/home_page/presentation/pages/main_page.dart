import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/card_states.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/cards_cubit.dart';
import 'package:life_makers/features/home_page/cubit/emergency_campaigns_cubit.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/home_app_bar.dart';
import 'package:life_makers/features/home_page/cubit/home_calender_cubit.dart';
import 'package:life_makers/features/home_page/presentation/pages/home_calender_details_screen.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/urgent_campaigns.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/user_details_card.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:page_transition/page_transition.dart';

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
        body: BlocBuilder<CardCubit, CardStates>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  const UserDetailsCard(),
                  const UrgentCampaigns(),
                  Expanded(
                    child: BlocBuilder<HomeCalenderCubit, CubitBaseState>(
                        builder: (context, state) {
                      if (state == CubitBaseState.done) {
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeCalenderCubit
                                .homeCalenderModel?.calender?.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return buildHomeCalenderItem(
                                  calender: homeCalenderCubit
                                      .homeCalenderModel?.calender?[index]);
                            });
                      } else if (state == CubitBaseState.loading) {
                        return Center(
                            child: CircularProgressIndicator.adaptive(
                        ));
                      }
                      return SizedBox.shrink();
                    }),
                  ),
                  SizedBox(height: 96.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  buildHomeCalenderItem({required Calender? calender}) => InkWell(
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 400),
                  child: HomeCalenderDetailsScreen(calender: calender)));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          height: 105.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 250.w,
                child: Text(
                  '${calender?.name}',
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                  style: TextStyle(
                      height: 2.h,
                      color: Colors.black,
                      fontFamily: FontFamilies.alexandria,
                      fontWeight: FontWeight.w400,
                      fontSize: 11),
                ),
              ),
              SizedBox(width: 12.w),
              Padding(
                padding: EdgeInsets.only(right: 13.5.w),
                child: CircleAvatar(
                  backgroundColor: AppColors.blueColor,
                  radius: 35.r,
                  child: Text(
                    '${calender?.date}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamilies.alexandria),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

}
