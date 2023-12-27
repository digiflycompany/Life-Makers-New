import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/suggestion_cubit.dart';
import 'package:life_makers/features/volunteer_opportunity/cubit/suggestion_states.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/activity_program.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/missions_program.dart';
import 'package:life_makers/features/volunteer_opportunity/presentation/screens/training_programs.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../campaign_details/presentation/widgets/send_button.dart';

class VolunteerOpportunityScreen extends StatefulWidget {
  const VolunteerOpportunityScreen({super.key});

  @override
  State<VolunteerOpportunityScreen> createState() =>
      _VolunteerOpportunityScreenState();
}

class _VolunteerOpportunityScreenState
    extends State<VolunteerOpportunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: CustomAppBar('فرص تطوعية'),
        preferredSize: Size(double.infinity, 50.h),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 300),
                                child: const TrainingPrograms()));
                      },
                      child: Image.asset(
                        AppAssets.volunteerCard1,
                        scale: 0.85,
                      )),
                  SizedBox(
                    height: 25.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 300),
                                child: const ActivityProgram()));
                      },
                      child: Image.asset(
                        AppAssets.volunteerCard2,
                        scale: 0.85,
                      )),
                  SizedBox(
                    height: 25.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 300),
                                child: const MissionsProgram()));
                      },
                      child: Image.asset(
                        AppAssets.volunteerCard3,

                        scale: 0.85,
                      )),
                  SizedBox(
                    height: 25.h,
                  ),
                  if(!PreferencesHelper.getIsVisitor)...[
                    GestureDetector(
                        onTap: () {
                          _showSuggestionPopup(context);
                        },
                        child: Image.asset(
                          AppAssets.volunteerCard4,
                          scale: 0.85,
                        )),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuggestionPopup(BuildContext context) {
    final suggestionCubit = BlocProvider.of<SuggestionCubit>(context);
    suggestionCubit.ResetStates();
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<SuggestionCubit, SuggestionState>(
          listener: (context, state) {
            if (state is SuggestionSuccess) {
              controller.clear();
              suggestionCubit.finalFile.isNull;
              Navigator.pop(context);
              CustomSnackBars.showSuccessToast(
                title: AppStrings.suggestionSentSuccessfully,
              );
            }
          },
          builder: (context, state) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.r))),
                insetPadding: const EdgeInsets.all(26),
                scrollable: true,
                titlePadding: const EdgeInsets.all(0),
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 505.h,
                  width: 450.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: state is SuggestionLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.orangeBorderColor,
                          ),
                        )
                      : Column(
                          textDirection: TextDirection.rtl,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 22.h, right: 23.w),
                                    child: SvgPicture.asset(
                                      AppAssets.darkCancelIcon,
                                      width: 17.w,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            const Text(
                              AppStrings.suggestion,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: FontFamilies.alexandria,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: Container(
                                width: double.infinity,
                                height: 270.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.w),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: controller,
                                    textDirection: TextDirection.rtl,
                                    maxLines: 5,
                                    decoration: InputDecoration.collapsed(
                                      hintTextDirection: TextDirection.rtl,
                                      hintText: AppStrings.message,
                                      hintStyle: TextStyle(
                                          color: AppColors.smallTextColor,
                                          fontFamily: FontFamilies.alexandria,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            InkWell(
                              onTap: () {
                                suggestionCubit.pickFile(controller.text);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: DottedBorder(
                                  radius: const Radius.circular(5),
                                  borderType: BorderType.RRect,
                                  color: Colors.grey,
                                  child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    color: state is FileUploadSuccess
                                        ? Colors.green
                                        : Colors.white,
                                    child: state is FileUploadSuccess
                                        ? Center(
                                            child: Text(
                                              AppStrings
                                                  .photoUploadedSuccessfully,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    FontFamilies.alexandria,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                AppStrings.attachAPhoto,
                                                style: TextStyle(
                                                  color: Color(0xff8E8E8E),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      FontFamilies.alexandria,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              SizedBox(width: 6.w),
                                              SvgPicture.asset(
                                                  AppAssets.uploadPhoto),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 22.h,
                            ),
                            SendButton(onTap: () {
                              suggestionCubit.SubmitSuggestion();
                            })
                          ],
                        ),
                ));
          },
        );
      },
    );
  }

  get title => TitleText(text: AppStrings.volunteerOpportunities);
  get popUpIcon => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            AppAssets.popUpIcon,
          ),
        ),
      );
  get header => Row(
        children: [
          SizedBox(
            width: 165.w,
          ),
          title,
          SizedBox(
            width: 111.w,
          ),
          popUpIcon,
        ],
      );
}
