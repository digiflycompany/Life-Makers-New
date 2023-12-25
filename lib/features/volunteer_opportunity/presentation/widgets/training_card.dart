import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_states.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/training_program_details.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../cubit/volunteer_cubit.dart';

class TrainingCard extends StatefulWidget {
  const TrainingCard({super.key});

  @override
  State<TrainingCard> createState() => _TrainingCardState();
}

class _TrainingCardState extends State<TrainingCard> {
  late VolunteerCubit volunteerCubit;
  @override
  void initState() {
    volunteerCubit = context.read<VolunteerCubit>();
    volunteerCubit.getVolunteerProgramTraining();
    super.initState();
  }
  Future<void> _refresh() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await volunteerCubit.getVolunteerProgramTraining();
      setState(() {}); // Force a rebuild
    } catch (error) {
      if (kDebugMode) {
        print('Error refreshing data: $error');
      }
    }
  }

  // Future<void> _refresh() async {
    // Add logic to refresh data here
    // For example, you can call an API or reload the data from your data source
    // Here's an example:
    // volunteerCubit.getVolunteerProgramTraining(); // Replace with your method
  //}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 21.w),
        child: buildGridView(),
      ),
    );
  }

  Widget buildGridView() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<VolunteerCubit, VolunteerState>(
        builder: (context, state) {
        if(state is VolunteerProgramLoading)  {
          return Align(
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(
              color: AppColors.orangeBorderColor,
            ),
          );
        } else {
          return GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (1 / .84),
              crossAxisSpacing: 18.h, // Adjust the spacing between items horizontally
              mainAxisSpacing: 18.w,  // Adjust the spacing between items vertically
            ),
            itemCount: volunteerCubit.volunteerPracticalTrainingModel?.volunteerOpportunities?.length, // Number of items in the grid
            itemBuilder: (context, index) {
              // Replace the following with your actual components/widgets
              final   currentItem = volunteerCubit.volunteerPracticalTrainingModel!.volunteerOpportunities![index];
              if (kDebugMode) {
                print(currentItem);
              }
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 600),
                      child:  TrainingProgramDetails(index: index,)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.trainingCardColor,
                    border: Border.all(color: AppColors.darkBlueColor,width:1.6.w),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(right: 13.w),
                    child: Stack(
                      children: [
                        logoImg,
                        Column(
                        children: [
                          SizedBox(height: 12.h,),
                          dotsIcon,
                          Align(
                            alignment:AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: EdgeInsets.only(right: 0.w),
                              child:  Text(
                                '${volunteerCubit.volunteerPracticalTrainingModel?.volunteerOpportunities?[index].name}',
                                style: TextStyle(
                                    color: AppColors.darkBlueColor,
                                    fontFamily: FontFamilies.alexandria,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13.5
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 11.h,),
                          Align(
                            alignment:AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: EdgeInsets.only(right: 0.w),
                              child:  Text(
                                '${volunteerCubit.volunteerPracticalTrainingModel?.volunteerOpportunities?[index].shortDetails}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: FontFamilies.alexandria,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    height: 1.56
                                ),
                                textDirection: TextDirection.rtl,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h,),
                        ],
                      ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
  },
),
        color: AppColors.orangeBorderColor,
        backgroundColor: Colors.white,
      ),
    );
  }
  get logoImg => Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
          padding:  EdgeInsets.only(left: 9.w,bottom: 6.h),
          child: SvgPicture.asset(AppAssets.blueLifeMakersLogo,)
      ));
  get dotsIcon => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding:  EdgeInsets.only(left: 13.w),
        child: SvgPicture.asset(AppAssets.dotsIcon,height: 13.h,),
      ));
  // get titleText => Align(
  //   alignment:AlignmentDirectional.centerStart,
  //   child: Padding(
  //     padding: EdgeInsets.only(right: 0.w),
  //     child:  Text(
  //       '${volunteerCubit.volunteerPracticalTrainingModel?.volunteerOpportunities?[index].name}',
  //       style: TextStyle(
  //           color: AppColors.darkBlueColor,
  //           fontFamily: FontFamilies.alexandria,
  //           fontWeight: FontWeight.w500,
  //           fontSize: 13.5
  //       ),
  //     ),
  //   ),
  // );
  // get descriptionText => Align(
  //   alignment:AlignmentDirectional.centerStart,
  //   child: Padding(
  //     padding: EdgeInsets.only(right: 0.w),
  //     child: const Text(
  //       AppStrings.dummyData,
  //       style: TextStyle(
  //           color: Colors.black,
  //           fontFamily: FontFamilies.alexandria,
  //           fontWeight: FontWeight.w400,
  //           fontSize: 10,
  //           height: 1.56
  //       ),
  //       textDirection: TextDirection.rtl,
  //       maxLines: 3,
  //     ),
  //   ),
  // );
  get calendarIcon => SvgPicture.asset(AppAssets.calendarIcon,width: 12.w,);
  get dateText => Padding(
    padding:  EdgeInsets.only(top: 2.h),
    child: const Text(
      AppStrings.date,
      style: TextStyle(
          color: Colors.grey,
          fontFamily: FontFamilies.alexandria,
          fontWeight: FontWeight.w400,
          fontSize: 9.5
      ),
    ),
  );
  // get content => Column(
  //   children: [
  //     SizedBox(height: 12.h,),
  //     dotsIcon,
  //     titleText,
  //     SizedBox(height: 11.h,),
  //     descriptionText,
  //     SizedBox(height: 8.h,),
  //   ],
  // );
  // get trainingCard => GestureDetector(
  //   onTap: (){
  //     Navigator.push(context, PageTransition(
  //         type: PageTransitionType.fade,
  //         duration: const Duration(milliseconds: 600),
  //         child: const OneDayActivityScreen()));
  //   },
  //   child: Container(
  //     decoration: BoxDecoration(
  //       color: AppColors.trainingCardColor,
  //       border: Border.all(color: AppColors.darkBlueColor,width:1.6.w),
  //       borderRadius: BorderRadius.circular(20.r),
  //     ),
  //     child: Padding(
  //       padding:  EdgeInsets.only(right: 13.w),
  //       child: Stack(
  //         children: [
  //           logoImg,
  //           content,
  //         ],
  //       ),
  //     ),
  //   ),
  // );
}
