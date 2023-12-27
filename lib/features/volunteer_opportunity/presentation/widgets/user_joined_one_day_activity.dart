import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/volunteer_states.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/one_day_activity_details.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../cubit/volunteer_cubit.dart';

class JoinedOneDayActivity extends StatefulWidget {
  const JoinedOneDayActivity({super.key});

  @override
  State<JoinedOneDayActivity> createState() => _JoinedOneDayActivityState();
}

class _JoinedOneDayActivityState extends State<JoinedOneDayActivity> {
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
                child: CircularProgressIndicator(
                  color: AppColors.orangeBorderColor,
                ),
              );
            } else if(state is JoinedProgramSuccess ){
              return GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1 / .84),
                  crossAxisSpacing: 18.h, // Adjust the spacing between items horizontally
                  mainAxisSpacing: 18.w,  // Adjust the spacing between items vertically
                ),
                itemCount: volunteerCubit.userJoinedVolunteerOpportunities?.activityVolunteerOpportunities?.length, // Number of items in the grid
                itemBuilder: (context, index) {
                  // Replace the following with your actual components/widgets
                  final   currentItem = volunteerCubit.userJoinedVolunteerOpportunities!.activityVolunteerOpportunities![index];
                  if (kDebugMode) {
                    print(currentItem);
                  }
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 600),
                          child:  OneDayActivityDetails(index: index,)));
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
                                      '${volunteerCubit.userJoinedVolunteerOpportunities?.activityVolunteerOpportunities?[index].name}',
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
                                      '${volunteerCubit.userJoinedVolunteerOpportunities?.activityVolunteerOpportunities?[index].shortDetails}',
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.noCampaignsImg),
                    SizedBox(height: 30.h,),
                    const Text(
                      'لا يوجد أنشطة',
                      style: TextStyle(
                          color:AppColors.greyNoCampaignsTextColor,
                          fontFamily: FontFamilies.alexandria,
                          fontWeight: FontWeight.w500,
                          fontSize: 13
                      ),
                    )
                  ],
                ),
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
