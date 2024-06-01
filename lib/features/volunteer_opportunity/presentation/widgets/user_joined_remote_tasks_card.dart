import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_states.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/training_program_details.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../cubit/volunteer_cubit.dart';

class JoinedRemoteTasks extends StatefulWidget {
  const JoinedRemoteTasks({super.key});

  @override
  State<JoinedRemoteTasks> createState() => _JoinedRemoteTasksState();
}

class _JoinedRemoteTasksState extends State<JoinedRemoteTasks> {
  late VolunteerCubit volunteerCubit;
  @override
  void initState() {
    volunteerCubit = context.read<VolunteerCubit>();
    volunteerCubit.getJoinedVolunteerOpportunities();
    super.initState();
  }
  Future<void> _refresh() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await volunteerCubit.getJoinedVolunteerOpportunities();
      setState(() {}); // Force a rebuild
    } catch (error) {
      if (kDebugMode) {
        print('Error refreshing data: $error');
      }
    }
  }
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

  Widget buildGridView(

      ) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocBuilder<VolunteerCubit, VolunteerState>(
          builder: (context, state) {
            if(state is JoinedProgramLoading)  {
              return Align(
                alignment: AlignmentDirectional.center,
                child: CircularProgressIndicator.adaptive(
                ),
              );
            } else if(state is JoinedProgramSuccess && volunteerCubit.userJoinedVolunteerOpportunities?.tasksVolunteerOpportunities?.length!=0){
              return GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / .84),
                  crossAxisSpacing: 18.h, // Adjust the spacing between items horizontally
                  mainAxisSpacing: 18.w,  // Adjust the spacing between items vertically
                ),
                itemCount: volunteerCubit.userJoinedVolunteerOpportunities?.tasksVolunteerOpportunities?.length, // Number of items in the grid
                itemBuilder: (context, index) {
                  // Replace the following with your actual components/widgets
                  final   currentItem = volunteerCubit.userJoinedVolunteerOpportunities!.tasksVolunteerOpportunities![index];
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
                        color: AppColors.whiteColor2,
                        border: Border.all(color: AppColors.blueColor4,width:1.6.w),
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
                                      '${volunteerCubit.userJoinedVolunteerOpportunities?.tasksVolunteerOpportunities?[index].name}',
                                      style: TextStyle(
                                          color: AppColors.blueColor4,
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
                                      '${volunteerCubit.userJoinedVolunteerOpportunities?.tasksVolunteerOpportunities?[index].shortDetails}',
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
            } else{
              return Center(
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 135.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.noCampaignsImg),
                      SizedBox(height: 30.h,),
                      const Text(
                        'لا يوجد مهام',
                        style: TextStyle(
                            color:AppColors.greyColor4,
                            fontFamily: FontFamilies.alexandria,
                            fontWeight: FontWeight.w500,
                            fontSize: 13
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
        color: AppColors.orangeColor,
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
}
