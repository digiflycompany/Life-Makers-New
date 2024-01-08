import'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_appbar.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/elections/cubit/all_candidates_cubit.dart';
import 'package:life_makers/features/elections/cubit/vote_candidate_cubit.dart';
import 'package:life_makers/features/elections/presentation/widgets/elections_button.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';

class ElectionsScreen extends StatefulWidget {
  const ElectionsScreen({super.key});

  @override
  State<ElectionsScreen> createState() => _ElectionsScreenState();
}

class _ElectionsScreenState extends State<ElectionsScreen> {
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
          child: CustomAppBar(AppStrings.volunteerBoardOfDirectorsElections)),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Text(
                    'انتخابات رئيس مجلس ادارة المتطوعين',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      fontFamily: 'Alexandria',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'قم باختيار رئيس واحد للمجلس من بين هذه المجموعة المرشحة لرئاسة مجلس إدارة المتطوعين',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      fontFamily: 'Alexandria',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                buildLeaderGridView(),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Text(
                    'انتخابات أعضاء مجلس ادارة المتطوعين',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      fontFamily: 'Alexandria',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'قم باختيار 10 أعضاء للمجلس من بين هذه المجموعة المرشحة لعضوية مجلس إدارة المتطوعين',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      fontFamily: 'Alexandria',
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                buildGridView(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: button,
    );
  }

  get button {
    return BlocBuilder<VoteCandidateCubit, CubitBaseState>(
        builder: (context, state) {
      if (state == CubitBaseState.loading) {
        return SizedBox(
            height: 50.h,
            child: Center(child: CircularProgressIndicator.adaptive()));
      }
      return ElectionsButton(
          onTap: () {
            if (selectedVotedSet.length != 10) {
              CustomSnackBars.showInfoSnackBar(
                  title: 'يجب عليك اختيار 10 اعضاء');
            }
            if (selectedManagerId == null) {
              CustomSnackBars.showInfoSnackBar(
                  title: 'يجب عليك اختيار رئيس الانتخاب');
            }
            if (selectedVotedSet.length == 10 && selectedManagerId != null) {
              voteCandidateCubit.voteForCandidates(
                managerId: selectedManagerId!,
                votedList: selectedVotedSet.toList(),
                context: context,
              );
            }
          },
          text: AppStrings.done);
    });
  }

  Widget buildGridView() {
    return BlocBuilder<AllCandidatesCubit, CubitBaseState>(
      builder: (context, state) {
        if (state == CubitBaseState.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state == CubitBaseState.done) {
          return GridView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 210.h,
              crossAxisSpacing: 21.w,
              mainAxisSpacing: 21.w,
            ),
            children: allCandidatesCubit.allCandidatesModel!.voters!
                .where((element) => element.candidate == 2)
                .map((e) => InkWell(
                      onTap: () {
                        if (selectedVotedSet.length < 10 &&
                            selectedVotedSet.contains(e.id!) == false) {
                          selectedVotedSet.add(e.id!);
                        } else if (selectedVotedSet.length == 10 &&
                            selectedVotedSet.contains(e.id!) == false) {
                          CustomSnackBars.showInfoSnackBar(
                              title: 'الحد الأقصي لأنتخاب الاعضاء هو 10 اعضاء');
                        } else {
                          selectedVotedSet.remove(e.id!);
                        }
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: selectedVotedSet.contains(e.id!)
                                  ? AppColors.white
                                  : Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 1,
                            )
                          ],
                          color: selectedVotedSet.contains(e.id!)
                              ? AppColors.darkBlueColor
                              : AppColors.white,
                        ),
                        child: Stack(
                          children: [
                            Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15.w),
                                  child: Image.asset(
                                      AppAssets.electionsCardBackgroundImage),
                                )),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 7.h, right: 4, left: 4, top: 4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.r),
                                        topRight: Radius.circular(10.r)),
                                    child: Image.network(
                                      '${e.imageUrl}',
                                      height: 100.h,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.w, bottom: 6.h, left: 10.w),
                                    child: Text(
                                      '${e.details}',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: selectedVotedSet.contains(e.id!)
                                            ? AppColors.white
                                            : AppColors.black,
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
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Text(
                                      '${e.name}',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                        color: selectedVotedSet.contains(e.id!)
                                            ? AppColors.white
                                            : AppColors.black,
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
                    ))
                .toList(),
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
            return GridView(
                padding: EdgeInsets.only(bottom: 5),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 210.h,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 10,

                ),
                children: allCandidatesCubit.allCandidatesModel!.voters!
                    .where((element) => element.candidate == 1)
                    .map((e) => InkWell(
                          onTap: () {
                            selectedManagerId = e.id;
                            setState(() {});
                            if (kDebugMode) {
                              print('managere is ${e.id} ${e.name}');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: selectedManagerId == e.id
                                      ? Colors.white
                                      : Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                )
                              ],
                              color: selectedManagerId == e.id
                                  ? AppColors.darkBlueColor
                                  : Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15.w),
                                      child: Image.asset(AppAssets
                                          .electionsCardBackgroundImage),
                                    )),
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
                                      padding:
                                          EdgeInsets.only(right: 6, left: 6),
                                      child: Text(
                                        '${e.details}',
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          color: selectedManagerId == e.id
                                              ? AppColors.white
                                              : AppColors.darkBlueColor,
                                          fontFamily: FontFamilies.alexandria,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.w),
                                        child: Text(
                                          '${e.name}',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            color: selectedManagerId == e.id
                                                ? AppColors.white
                                                : AppColors.darkBlueColor,
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
                        ))
                    .toList());
          });
        }
        return const SizedBox.shrink();
      },
    );
  }
}
