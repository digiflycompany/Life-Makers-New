import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../cubit/all_candidates_cubit.dart';


class CandidateDetails extends StatefulWidget {
  final int index;
  CandidateDetails({required this.index});
  @override
  State<CandidateDetails> createState() => _CandidateDetailsState();
}

class _CandidateDetailsState extends State<CandidateDetails> {
  late AllCandidatesCubit allCandidatesCubit;

  @override
  void initState() {
    allCandidatesCubit = context.read<AllCandidatesCubit>();
    allCandidatesCubit.getAllCandidates(context: context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllCandidatesCubit, CubitBaseState>(
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
                                      AppAssets.loadingImg,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      height: 300.h,
                                    ),
                                  ),
                                  Image.network('${allCandidatesCubit.allCandidatesModel?.voters?[widget.index].imageUrl}',
                                    width: double.infinity, fit: BoxFit.fill,height: 300.h,),
                                ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 1),
                          child: Container(
                            width: 90,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.orangeBackgroundColor,
                            ),
                            child: Center(
                              child: Text(
                                'بيانات شخصية',
                                style: TextStyle(
                                  fontFamily: FontFamilies.alexandria,
                                  fontSize: 11.2,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.orangeBorderColor
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'الاسم :',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue.shade900,
                                fontSize: 10.5,
                                fontFamily: FontFamilies.alexandria,
                                height: 2.5,
                              ),
                            ),
                            SizedBox(width: 9.w,),
                            Padding(
                              padding:  EdgeInsets.only(bottom: 3.0),
                              child: Text(
                                '${allCandidatesCubit.allCandidatesModel?.voters?[widget.index].name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: FontFamilies.alexandria,
                                  height: 2.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'تاريخ الميلاد :',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue.shade900,
                                fontSize: 10.5,
                                fontFamily: FontFamilies.alexandria,
                                height: 2.5,
                              ),
                            ),
                            SizedBox(width: 9.w,),
                            Padding(
                              padding:  EdgeInsets.only(bottom: 3.0),
                              child: Text(
                                '${allCandidatesCubit.allCandidatesModel?.voters?[widget.index].birthDate}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: FontFamilies.alexandria,
                                  height: 2.5,
                                ),
                              ),
                            ),
                            SizedBox(width: 46.w,),
                            Text(
                              'المحافظة :',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue.shade900,
                                fontSize: 10.5,
                                fontFamily: FontFamilies.alexandria,
                                height: 2.5,
                              ),
                            ),
                            SizedBox(width: 9.w,),
                            Padding(
                              padding:  EdgeInsets.only(bottom: 3.0),
                              child: Text(
                                '${allCandidatesCubit.allCandidatesModel?.voters?[widget.index].city}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: FontFamilies.alexandria,
                                  height: 2.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 1),
                          child: Container(
                            width: 52,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.orangeBackgroundColor,
                            ),
                            child: Center(
                              child: Text(
                                'المقعد',
                                style: TextStyle(
                                    fontFamily: FontFamilies.alexandria,
                                    fontSize: 11.2,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.orangeBorderColor
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(
                              'مترشح لمقعد :',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue.shade900,
                                fontSize: 10.5,
                                fontFamily: FontFamilies.alexandria,
                                height: 2.5,
                              ),
                            ),
                            SizedBox(width: 9.w,),
                            Padding(
                              padding:  EdgeInsets.only(bottom: 3.0),
                              child: Text(
                                '${allCandidatesCubit.allCandidatesModel?.voters?[widget.index].candidateFor}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: FontFamilies.alexandria,
                                  height: 2.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 1),
                          child: Container(
                            width: 42,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.orangeBackgroundColor,
                            ),
                            child: Center(
                              child: Text(
                                'وصف',
                                style: TextStyle(
                                    fontFamily: FontFamilies.alexandria,
                                    fontSize: 11.2,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.orangeBorderColor
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(bottom:20.0),
                          child: Center(
                            child: Text(
                              '${allCandidatesCubit.allCandidatesModel?.voters?[widget.index].details}',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: FontFamilies.alexandria,
                                height: 2.5,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: 3.h, bottom: 20.h),
                          child: Container(
                            width: 52.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.orangeBackgroundColor,
                            ),
                            child: Center(
                              child: Text(
                                'انجازات',
                                style: TextStyle(
                                    fontFamily: FontFamilies.alexandria,
                                    fontSize: 11.2,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.orangeBorderColor
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(bottom:45.h),
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              height: 250.h,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: AppColors.greyTabColor),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: allCandidatesCubit.allCandidatesModel?.voters?[widget.index].achievements?.length ?? 0,
                                itemBuilder: (BuildContext context, int index) {
                                  if (allCandidatesCubit.allCandidatesModel?.voters?[widget.index].achievements != null &&
                                      index < allCandidatesCubit.allCandidatesModel!.voters![widget.index].achievements!.length) {
                                    final achievement = allCandidatesCubit.allCandidatesModel!.voters![widget.index].achievements![index];
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                                      child: Row(
                                        textDirection: TextDirection.rtl,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left: 9.w),
                                            child: SvgPicture.asset(AppAssets.achievementsIcon),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '$achievement', // Use the specific achievement at the current index
                                              style: TextStyle(
                                                height: 1.6,
                                                fontFamily: FontFamilies.alexandria,
                                                fontSize: 10.2,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.orangeBorderColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
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
