import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/widgets/custom_appbar.dart';
import 'package:life_makers/features/campaign_details/cubit/join_campaign_cubit.dart';
import 'package:life_makers/features/campaign_details/presentation/widgets/send_button.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widgets/title_text.dart';
import '../widgets/button.dart';

class JoinCampaignDetails extends StatefulWidget {
  JoinCampaignDetails(
      {super.key, required this.taskId, required this.campaignDetails});

  final int taskId;
  final Campaigns? campaignDetails;

  @override
  State<JoinCampaignDetails> createState() => _JoinCampaignDetailsState();
}

class _JoinCampaignDetailsState extends State<JoinCampaignDetails> {
  late JoinCampaignCubit joinCampaignCubit;

  @override
  void initState() {
    super.initState();
    joinCampaignCubit = context.read<JoinCampaignCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar('${widget.campaignDetails?.name}'),
        preferredSize: Size(double.infinity, 50.h),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(
                  '${widget.campaignDetails?.photo}',
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 17.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${widget.campaignDetails?.name}',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: FontFamilies.alexandria,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  SizedBox(height: 6.h),
                  date,
                  SizedBox(height: 15.h),
                  campaignContent,
                  SizedBox(height: 11.h),
                  SizedBox(height: 19.h),
                  campaignMissionsText,
                  SizedBox(height: 20.h),
                  if(widget.campaignDetails?.userJoined=='false')
                  Container(
                    padding:
                        EdgeInsets.only(top: 10.h, right: 10, bottom: 30.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.7.w),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.campaignDetails!.tasks!
                          .where((element) => element.id == widget.taskId)
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: e.details!
                                    .map((e) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                e,
                                                style: TextStyle(
                                                    fontFamily: 'Alexandria',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: AppColors
                                                      .orangeColor,
                                                  child: Icon(
                                                    Icons.done_outline,
                                                    size: 20,
                                                  )),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 30.h
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.campaignDetails?.userJoined == 'true')
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              width: 390.w,
              height: 63.h,
              decoration: BoxDecoration(
                color: AppColors.orangeColor,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showSuggestionPopup(
                              context: context, taskId: widget.taskId);
                        },
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            SvgPicture.asset(
                              AppAssets.suggestionIcon,
                              width: 18.w,
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            const Text(
                              AppStrings.suggestion,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontFamilies.alexandria,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      SizedBox(
                        height: 40.h,
                        child: const VerticalDivider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showComplainPopup(
                              taskId: widget.taskId, context: context);
                        },
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            SvgPicture.asset(
                              AppAssets.complainIcon,
                              width: 18.w,
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            const Text(
                              AppStrings.complain,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontFamilies.alexandria,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      SizedBox(
                        height: 40.h,
                        child: const VerticalDivider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showLeavingPopup(context);
                        },
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            SvgPicture.asset(
                              AppAssets.joinCampaignIcon,
                              width: 18.w,
                            ),
                            SizedBox(
                              width: 7.w,
                            ),
                            const Text(
                              AppStrings.leaveCampaign,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontFamilies.alexandria,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.5),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  get title => TitleText(text: AppStrings.palestine2);
  get popUpIcon => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          AppAssets.popUpIcon,
        ),
      );
  get header => Row(
        children: [
          SizedBox(
            width: 140.w,
          ),
          title,
          SizedBox(
            width: 105.w,
          ),
          popUpIcon,
        ],
      );
  get campaignImg => AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.asset(
        AppAssets.palestineImg,
        fit: BoxFit.cover,
      ));
  get date => Padding(
        padding: EdgeInsets.only(right: 0.w),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            calendarIcon,
            SizedBox(
              width: 4.w,
            ),
            dateText,
          ],
        ),
      );
  get calendarIcon => SvgPicture.asset(
        AppAssets.calendarIcon,
        width: 10.w,
      );
  get dateText => Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Text(
          '${widget.campaignDetails?.startAt}'.split((' ')).first,
          style: TextStyle(
              color: Colors.grey,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w400,
              fontSize: 8),
        ),
      );
  get campaignContent => Text(
        '${widget.campaignDetails?.details}',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 11,
          fontFamily: FontFamilies.alexandria,
          height: 1.8.h,
        ),
        textDirection: TextDirection.rtl,
      );
  get campaignButton => Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Button(onTap: () {}, text: AppStrings.campaignButtonText),
      );
  get campaignMissionsText => Padding(
        padding: EdgeInsets.only(right: 6.w),
        child: const Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            AppStrings.campaignMissions,
            style: TextStyle(
                color: Colors.black,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
      );

  void _showSuggestionPopup(
      {required BuildContext context, required int taskId}) {
    String? suggestion;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.r))),
            insetPadding: const EdgeInsets.all(26),
            scrollable: true,
            titlePadding: const EdgeInsets.all(0),
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: 432.h,
              width: 450.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Padding(
                          padding: EdgeInsets.only(top: 22.h, right: 23.w),
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
                        border: Border.all(color: Colors.grey, width: 1.w),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (val) {
                            suggestion = val;
                          },
                          textDirection: TextDirection.rtl,
                          maxLines: 5,
                          decoration: InputDecoration.collapsed(
                            hintTextDirection: TextDirection.rtl,
                            hintText: AppStrings.message,
                            hintStyle: TextStyle(
                                color: AppColors.blueColor6,
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
                  SendButton(
                    onTap: () {
                      if (suggestion != null) {
                        joinCampaignCubit.sendCampaignSuggestion(
                            taskId: taskId,
                            suggestion: suggestion!,
                            context: context);
                      }
                    },
                  )
                ],
              ),
            ));
      },
    );
  }

  void _showComplainPopup(
      {required BuildContext context, required int taskId}) {
    String? complaign;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.r))),
            insetPadding: const EdgeInsets.all(26),
            scrollable: true,
            titlePadding: const EdgeInsets.all(0),
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: 432.h,
              width: 450.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Padding(
                          padding: EdgeInsets.only(top: 22.h, right: 23.w),
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
                    AppStrings.complain,
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
                        border: Border.all(color: Colors.grey, width: 1.w),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (val) {
                            complaign = val;
                          },
                          textDirection: TextDirection.rtl,
                          maxLines: 5,
                          decoration: InputDecoration.collapsed(
                            hintTextDirection: TextDirection.rtl,
                            hintText: AppStrings.message,
                            hintStyle: TextStyle(
                                color: AppColors.blueColor6,
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
                  SendButton(onTap: () async {
                    if (complaign != null) {
                      joinCampaignCubit.sendCampaignComplaign(
                          campaignId: taskId,
                          complaign: complaign!,
                          context: context);
                    }
                  })
                ],
              ),
            ));
      },
    );
  }

  void _showLeavingPopup(BuildContext context) {
    String? leaveReason;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.r))),
            insetPadding: const EdgeInsets.all(26),
            scrollable: true,
            titlePadding: const EdgeInsets.all(0),
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: 432.h,
              width: 450.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Padding(
                          padding: EdgeInsets.only(top: 22.h, right: 23.w),
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
                    AppStrings.leavingReason,
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
                        border: Border.all(color: Colors.grey, width: 1.w),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (val) {
                            leaveReason = val;
                          },
                          textDirection: TextDirection.rtl,
                          maxLines: 5,
                          decoration: InputDecoration.collapsed(
                            hintTextDirection: TextDirection.rtl,
                            hintText: AppStrings.message,
                            hintStyle: TextStyle(
                                color: AppColors.blueColor6,
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
                  SendButton(onTap: () async {
                    joinCampaignCubit.leaveCampaign(
                        campaignId: 0,
                        context: context,
                        leaveReason: leaveReason);
                  })
                ],
              ),
            ));
      },
    );
  }
}

void showSuccessPopUp(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext _) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.r))),
          insetPadding: const EdgeInsets.all(26),
          scrollable: true,
          titlePadding: const EdgeInsets.all(0),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 260.h,
            width: 360.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  AppStrings.requestRegistered,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamilies.alexandria,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      AppAssets.successIcon,
                      width: 100.w,
                    )),
                const Text(
                  AppStrings.waitForApproval,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamilies.alexandria,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ));
    },
  );
}
