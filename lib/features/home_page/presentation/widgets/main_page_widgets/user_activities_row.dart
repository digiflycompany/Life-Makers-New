import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/card_states.dart';
import 'package:life_makers/features/authentication/cubit/card_cubit/cards_cubit.dart';
import 'package:life_makers/features/authentication/presentation/widgets/volunteers_card.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/card_circular_progress_indicator.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/no_activities_text.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class UserActivities extends StatelessWidget {
  const UserActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCubit, CardStates>(
      builder: (context, state) {
        final cardCubit=context.read<CardCubit>();
        return Padding(
          padding: EdgeInsets.only(top: 9.h),
          child: Column(
            children: [
              if (state is CardLoading && !PreferencesHelper.getIsVisitor) ...[
                const CardCircularProgressIndicator(),
                if (state is CardSuccess) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Container(
                      height: 52.h,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        itemCount: cardCubit
                            .currentJoinedCampaignsAndOpp
                            ?.currentVolunteerOpportunities
                            ?.length,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              Routes.volunteerCardDetailsPage.moveTo(index);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: VolunteerContainer(
                                  itemName:
                                  "${cardCubit.currentJoinedCampaignsAndOpp?.currentVolunteerOpportunities![index].name}"),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ],
              if (state is CardSuccess &&
                  cardCubit.currentJoinedCampaignsAndOpp
                      ?.currentVolunteerOpportunities?.length ==
                      0) ...[
                const NoActivitiesText(),
              ]
            ],
          ),
        );
      },
    );
  }
}
