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
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';


class CandidateDetails extends StatefulWidget {
 // final int index;
  //CandidateDetails({required this.index});
  CandidateDetails();
  @override
  State<CandidateDetails> createState() => _CandidateDetailsState();
}

class _CandidateDetailsState extends State<CandidateDetails> {
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
          // if(state is JoinOneDayActivitySuccess){
          //   oneDayActivityCubit.oneDayActivityModel?.volunteerOpportunities![widget.index].userJoined='pending';
          //   Navigator.push(context, PageTransition(
          //       type: PageTransitionType.fade,
          //       duration: const Duration(milliseconds: 450),
          //       child:  VolunteerThanksScreen()));
          // }
          // if(state is leftOneDayActivitySuccess){
          //   oneDayActivityCubit.oneDayActivityModel?.volunteerOpportunities![widget.index].userJoined='false';
          //   CustomSnackBars.showSuccessToast(title: AppStrings.volunteerHasBeenLeftSuccessfully,);
          // }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              child: CustomAppBar('مرشحي مجلس ادارة المتطوعين'),
              preferredSize: Size(double.infinity, 50.h),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        PreferredSize(
                          preferredSize: Size(double.infinity, 372),
                          child: SafeArea(
                            child: Stack(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 0.w),
                                    child: Image.asset(
                                      AppAssets.yousefImage,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      height: 300.h,
                                    ),
                                  ),
                                  // Image.network('${oneDayActivityCubit.oneDayActivityModel
                                  //     ?.volunteerOpportunities![widget.index].photo}',
                                  //   width: double.infinity, fit: BoxFit.fill,height: 300.h,),
                                ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Container(
                            width: 90,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.orangeBackgroundColor,
                            ),
                            child: Center(
                              child: Text(
                                // '${oneDayActivityCubit.oneDayActivityModel
                                //     ?.volunteerOpportunities![widget.index].name}',
                                'بيانات شخصية',
                                style: TextStyle(
                                  fontFamily: FontFamilies.alexandria,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.orangeBorderColor
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          // '${oneDayActivityCubit.oneDayActivityModel
                          //     ?.volunteerOpportunities![widget.index].details}',
                          '',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            fontFamily: FontFamilies.alexandria,
                            height: 2.5,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
