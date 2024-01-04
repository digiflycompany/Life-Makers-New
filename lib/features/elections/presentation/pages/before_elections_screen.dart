import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_appbar.dart';
import 'package:life_makers/features/elections/cubit/all_candidates_cubit.dart';
import 'package:life_makers/features/elections/cubit/vote_candidate_cubit.dart';
import 'package:life_makers/features/elections/presentation/pages/candidate_details.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app_fonts.dart';

class BeforeElectionsScreen extends StatefulWidget {
  const BeforeElectionsScreen({super.key});

  @override
  State<BeforeElectionsScreen> createState() => _BeforeElectionsScreenState();
}

class _BeforeElectionsScreenState extends State<BeforeElectionsScreen> {
  late AllCandidatesCubit allCandidatesCubit;
  late VoteCandidateCubit voteCandidateCubit;
  Set<int> selectedVotedSet = {};

  int? selectedManagerId;

  @override
  void initState() {
    super.initState();
    allCandidatesCubit = context.read<AllCandidatesCubit>();
    voteCandidateCubit = context.read<VoteCandidateCubit>();
    allCandidatesCubit.getAllCandidates(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50.h),
          child: CustomAppBar("مرشحين مجلس ادارة المتطوعين")),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 17),
                  child: Center(
                    child: Text(
                      'مرشحين رئيس مجلس ادارة المتطوعين',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        fontFamily: 'Alexandria',
                      ),
                    ),
                  ),
                ),
                buildLeaderGridView(),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 17),
                  child: Center(
                    child: Text(
                      'مرشحين أعضاء مجلس ادارة المتطوعين',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        fontFamily: 'Alexandria',
                      ),
                    ),
                  ),
                ),
                buildGridView(),
                SizedBox(height: 25.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGridView() {
    return BlocBuilder<AllCandidatesCubit, CubitBaseState>(
      builder: (context, state) {
        if (state == CubitBaseState.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state == CubitBaseState.done) {
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            mainAxisExtent: 220.h,
              crossAxisSpacing: 18.w,
              mainAxisSpacing: 18.w,
            ),
           itemCount: allCandidatesCubit.allCandidatesModel?.voters?.length ?? 0,
           itemBuilder:(context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 600),
                      child:  CandidateDetails(index: index,)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 1,
                      )
                    ],
                    color: AppColors.white,
                  ),
                  child: Stack(
                    children: [
                      Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.w,),
                            child: Image.asset(
                                AppAssets.electionsCardBackgroundImage),
                          )),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 7.h, right: 4, left: 4, top: 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r)),
                              child: Image.network(
                                '${allCandidatesCubit.allCandidatesModel?.voters?[index].imageUrl}',
                                height: 100.h,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w,bottom: 8.h,left: 25.w),
                              child: Text(
                                '${allCandidatesCubit.allCandidatesModel?.voters![index].name}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontFamily: FontFamilies.alexandria,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                           ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 10.w, bottom: 2.h, left: 5.w),
                              child: Text(
                                'محافظة: ${allCandidatesCubit.allCandidatesModel?.voters![index].city}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontFamily: FontFamilies.alexandria,
                                  fontWeight: FontWeight.w400,
                                  fontSize:9,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              );
           }
            );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget buildLeaderGridView() {
    return BlocBuilder<AllCandidatesCubit, CubitBaseState>(
      builder: (context, state) {
        if (state == CubitBaseState.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        else if (state == CubitBaseState.done) {
          return StatefulBuilder(builder: (context, setState) {
            return GridView.builder(
              padding: EdgeInsets.only(bottom: 5),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 220.h,
                crossAxisSpacing: 9,
                mainAxisSpacing: 10,
              ),
              itemCount: allCandidatesCubit.allCandidatesModel!.voters!
                  .where((element) => element.candidate == 1)
                  .length,
              itemBuilder: (BuildContext context, int index) {
                var e = allCandidatesCubit.allCandidatesModel!.voters!
                    .where((element) => element.candidate == 1)
                    .toList()[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 600),
                        child: CandidateDetails(
                          index: allCandidatesCubit.allCandidatesModel!.voters!
                              .indexWhere((element) => element.candidate == 1 && element == e),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 1,
                        )
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: Image.asset(AppAssets.electionsCardBackgroundImage),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 7.h),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    topRight: Radius.circular(10.r)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    '${e.imageUrl}',
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 6, left: 6),
                              child: Text(
                                '${e.details}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: AppColors.darkBlueColor,
                                  fontFamily: FontFamilies.alexandria,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Text(
                                  '${e.name}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: AppColors.darkBlueColor,
                                    fontFamily: FontFamilies.alexandria,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
