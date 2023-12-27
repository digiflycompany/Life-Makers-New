import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/home_page/presentation/widgets/news_button.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/one_day_activity_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/one_day_activity_states.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/volunteers_thanks_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';


class OneDayActivityDetails extends StatefulWidget {
  final int index;

  OneDayActivityDetails({required this.index});

  @override
  State<OneDayActivityDetails> createState() => _OneDayActivityDetailsState();
}

class _OneDayActivityDetailsState extends State<OneDayActivityDetails> {
  late OneDayActivityCubit oneDayActivityCubit;
  @override
  void initState() {
    oneDayActivityCubit = context.read<OneDayActivityCubit>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OneDayActivityCubit, OneDayActivityState>(
        listener: (context, state) {
          if(state is JoinOneDayActivitySuccess){
            oneDayActivityCubit.oneDayActivityModel?.volunteerOpportunities![widget.index].userJoined='pending';
            Navigator.push(context, PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 450),
                child:  VolunteerThanksScreen()));
          }
          if(state is leftOneDayActivitySuccess){
            oneDayActivityCubit.oneDayActivityModel?.volunteerOpportunities![widget.index].userJoined='false';
            CustomSnackBars.showSuccessToast(title: AppStrings.volunteerHasBeenLeftSuccessfully,);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 372),
              child: SafeArea(
                child: Stack(
                    children: [
                      Image.asset(
                        AppAssets.loadingImg,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        height: 300.h,
                      ),
                      Image.network('${oneDayActivityCubit.oneDayActivityModel
                          ?.volunteerOpportunities![widget.index].photo}',
                        width: double.infinity, fit: BoxFit.fill,height: 300.h,),
                      Positioned(
                        right: 13,
                        top: 16,
                        child: CircleAvatar(
                          radius: 20,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward, color: AppColors.gradientColor1,),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          backgroundColor: Color(0xffD9D9D9),
                        ),
                      )
                    ]
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          '${oneDayActivityCubit.oneDayActivityModel
                              ?.volunteerOpportunities![widget.index].name}',
                          style: TextStyle(
                            fontFamily: FontFamilies.alexandria,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/svg/calender.svg'),
                          SizedBox(width: 5),
                          Text(
                            '22-10-2023',
                            style: TextStyle(
                                fontFamily: 'Alexandria',
                                fontSize: 7,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      Text(
                        '${oneDayActivityCubit.oneDayActivityModel
                            ?.volunteerOpportunities![widget.index].details}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          fontFamily: FontFamilies.alexandria,
                          height: 2.5,
                        ),
                      ),
                      Spacer(),
                      if(!PreferencesHelper.getIsVisitor)...[
                        if( oneDayActivityCubit.oneDayActivityModel?.volunteerOpportunities![widget.index].userJoined=='true')
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: state is leftOneDayActivityLoading
                                ? Center(
                              child: Transform.scale(
                                scale: 0.5,
                                child: CircularProgressIndicator(
                                  color: AppColors.orangeBorderColor,
                                ),
                              ),
                            )
                                : NewsButton2(
                                onTap: () {
                                  oneDayActivityCubit.leftOneDayActivity('${oneDayActivityCubit.oneDayActivityModel?.volunteerOpportunities![widget.index].id}');
                                },
                                text: AppStrings.leave),
                          ),
                        if( oneDayActivityCubit.oneDayActivityModel?.volunteerOpportunities![widget.index].userJoined=='pending')
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: state is leftOneDayActivityLoading
                                ? Center(
                              child: Transform.scale(
                                scale: 0.5,
                                child: CircularProgressIndicator(
                                  color: AppColors.orangeBorderColor,
                                ),
                              ),
                            )
                                : pendingButton(
                                onTap: () {
                                  CustomSnackBars.showInfoSnackBar(title: AppStrings.pendingText);
                                },
                                text:AppStrings.pendingText),
                          ),
                        if( oneDayActivityCubit.oneDayActivityModel?.volunteerOpportunities![widget.index].userJoined=='false')
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: state is JoinOneDayActivityLoading
                                ? Center(
                              child: Transform.scale(
                                scale: 0.5,
                                child: CircularProgressIndicator(
                                  color: AppColors.orangeBorderColor,
                                ),
                              ),
                            )
                                : NewsButton2(
                                onTap: () {
                                  oneDayActivityCubit.JoinOneDayActivity('${oneDayActivityCubit.oneDayActivityModel?.volunteerOpportunities![widget.index].id}');
                                },
                                text: AppStrings.join),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
