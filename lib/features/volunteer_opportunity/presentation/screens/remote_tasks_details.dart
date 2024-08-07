import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/home_page/presentation/widgets/news_button.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/remote_tasks_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/remote_tasks_states.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/volunteers_thanks_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';


class RemoteTasksDetails extends StatefulWidget {
  final int index;

  RemoteTasksDetails({required this.index});

  @override
  State<RemoteTasksDetails> createState() => _RemoteTasksDetailsState();
}

class _RemoteTasksDetailsState extends State<RemoteTasksDetails> {
  late RemoteTasksCubit remoteTasksCubit;
  @override
  void initState() {
    remoteTasksCubit = context.read<RemoteTasksCubit>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RemoteTasksCubit, RemoteTasksState>(
        listener: (context, state) {
          if(state is JoinRemoteTasksSuccess){
              remoteTasksCubit.remoteTasksModel?.volunteerOpportunities![widget.index].userJoined='pending';
            Navigator.push(context, PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 450),
                child:  VolunteerThanksScreen()));
          }
          if(state is leftRemoteTasksSuccess){
            remoteTasksCubit.remoteTasksModel?.volunteerOpportunities![widget.index].userJoined='false';
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
                      Image.network('${remoteTasksCubit.remoteTasksModel
                          ?.volunteerOpportunities![widget.index].photo}',
                        width: double.infinity, fit: BoxFit.fill,height: 300.h,),
                      Positioned(
                        right: 13,
                        top: 16,
                        child: CircleAvatar(
                          radius: 20,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward, color: AppColors.blueColor,),
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
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 5),
                          child: Text(
                            '${remoteTasksCubit.remoteTasksModel
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
                                  fontFamily: FontFamilies.alexandria,
                                  fontSize: 7,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        Text(
                          '${remoteTasksCubit.remoteTasksModel
                              ?.volunteerOpportunities![widget.index].details}',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            fontFamily: FontFamilies.alexandria,
                            height: 2.5,
                          ),
                        ),
                        SizedBox(height: 20.h,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: !PreferencesHelper.getIsVisitor
                ?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if( remoteTasksCubit.remoteTasksModel?.volunteerOpportunities![widget.index].userJoined=='true')
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: state is leftRemoteTasksLoading
                        ? Center(
                      child: Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(
                          color: AppColors.orangeColor,
                        ),
                      ),
                    )
                        : NewsButton2(
                        onTap: () {
                          remoteTasksCubit.leftRemoteTasks('${remoteTasksCubit.remoteTasksModel?.volunteerOpportunities![widget.index].id}');
                        },
                        text: AppStrings.leave),
                  ),
                if( remoteTasksCubit.remoteTasksModel?.volunteerOpportunities![widget.index].userJoined=='pending')
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: state is leftRemoteTasksLoading
                        ? Center(
                      child: Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(
                          color: AppColors.orangeColor,
                        ),
                      ),
                    )
                        : PendingButton(
                        onTap: () {
                          // volunteerCubit.leftProgram('${volunteerCubit.volunteerPracticalTrainingModel?.volunteerOpportunities![widget.index].id}');
                          CustomSnackBars.showInfoSnackBar(title: AppStrings.pendingText);
                        },
                        text:AppStrings.pendingText),
                  ),
                if( remoteTasksCubit.remoteTasksModel?.volunteerOpportunities![widget.index].userJoined=='false')
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: state is JoinRemoteTasksLoading
                        ? Center(
                      child: Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(
                          color: AppColors.orangeColor,
                        ),
                      ),
                    )
                        : NewsButton2(
                        onTap: () {
                          remoteTasksCubit.joinRemoteTasks('${remoteTasksCubit.remoteTasksModel?.volunteerOpportunities![widget.index].id}');
                        },
                        text: AppStrings.join),
                  ),
            ],):SizedBox.shrink(),
          );
        }
    );
  }
}
