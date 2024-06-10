import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/widgets/custom_appbar.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/core/widgets/upload_image.dart';
import 'package:life_makers/features/campaign_details/cubit/join_campaign_cubit.dart';
import 'package:life_makers/features/campaign_details/presentation/widgets/send_button.dart';
import 'package:life_makers/features/home_page/presentation/widgets/news_button.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_content.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_date.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_image.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_name.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

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
    joinCampaignCubit.checkedIn = false;
    joinCampaignCubit.checkedOut = false;
    joinCampaignCubit.imagesUploadedToServer = false;
    joinCampaignCubit.image1Uploaded = false;
    joinCampaignCubit.image2Uploaded = false;
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoinCampaignCubit, CubitBaseState>(
      listener: (context, state) {
        if (state == CubitBaseState.campaignCheckedOut) {
          CustomSnackBars.showSuccessToast(
            title: 'تم تسجيل الانصراف بنجاح',
          );
        }
        // if(joinCampaignCubit.imagesUploadedToServer==true){
        //   CustomSnackBars.showSuccessToast(
        //     title: AppStrings.photosUploadedSuccessfully,
        //   );
        // }
        if (state == CubitBaseState.imagesSuccess) {
          CustomSnackBars.showSuccessToast(
            title: AppStrings.photosUploadedSuccessfully,
          );
        }
        if (state == CubitBaseState.imagesLoading) {
          Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      builder: (context, state) {
        return PopScope(
          onPopInvoked: (didPop) {
            joinCampaignCubit.resetState();
          },
          child: Scaffold(
            appBar: PreferredSize(
              child: CustomAppBar('${widget.campaignDetails?.name}'),
              preferredSize: Size(double.infinity, 50.h),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  CampaignImage(campaignDetails: widget.campaignDetails),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CampaignName(campaignDetails: widget.campaignDetails),
                        CampaignDate(campaignDetails: widget.campaignDetails),
                        CampaignContent(campaignDetails: widget.campaignDetails),
                        UploadImage(
                          text: joinCampaignCubit.image1Uploaded == true
                              ? AppStrings.photoUploadedSuccessfully
                              : AppStrings.uploadProfilePhoto,
                          textColor: joinCampaignCubit.image1Uploaded == true
                               ? Colors.white:AppColors.greyColor8,
                          uploadIcon: joinCampaignCubit.image1Uploaded == true
                               ? false:true,
                          fontSize: joinCampaignCubit.image1Uploaded == true
                               ? 15:10,
                          onTap: () {
                            if (joinCampaignCubit.checkedIn == true) {
                              joinCampaignCubit.pickProfileImage();
                            } else {
                              CustomSnackBars.showInfoSnackBar(
                                  title: 'قم بتسجيل الحضور');
                            }
                          },
                          color: joinCampaignCubit.image1Uploaded == true
                              ? AppColors.greenColor
                              : Colors.white,
                        ),
                        VerticalSpace(35.h),
                        UploadImage(
                          text: joinCampaignCubit.image2Uploaded == true
                              ? AppStrings.photoUploadedSuccessfully
                              : AppStrings.uploadCampaignPhoto,
                          textColor: joinCampaignCubit.image2Uploaded == true
                              ? Colors.white:AppColors.greyColor8,
                          uploadIcon: joinCampaignCubit.image2Uploaded == true
                              ? false:true,
                          fontSize: joinCampaignCubit.image2Uploaded == true
                              ? 15:10,
                          onTap: () {
                            if (joinCampaignCubit.checkedIn == true) {
                              joinCampaignCubit.pickUserInCampaignImage();
                            } else {
                              CustomSnackBars.showInfoSnackBar(
                                  title: 'قم بتسجيل الحضور');
                            }
                          },
                          color: joinCampaignCubit.image2Uploaded == true
                              ? AppColors.greenColor
                              : Colors.white,
                        ),
                        VerticalSpace(20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 70.w),
                          child: NewsButton4(
                            onTap: () {
                              if (joinCampaignCubit.image1Uploaded == true &&
                                  joinCampaignCubit.image1Uploaded == true) {
                                joinCampaignCubit.uploadFile(
                                    file: joinCampaignCubit.finalFile,
                                    file2: joinCampaignCubit.finalFile2,
                                    campaignId: widget.campaignDetails!.id);
                                CustomSnackBars.showInfoSnackBar(title: 'جاري رفع الصور انتظر قليلا...');
                              } else {
                                CustomSnackBars.showInfoSnackBar(
                                  title: 'من فضلك ارفق الصور',
                                );
                              }
                            },
                            text: 'ارفع الصور',
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 40.w, vertical: 20.h),
                          width: double.infinity,
                          height: 63.h,
                          decoration: BoxDecoration(
                            color: AppColors.orangeColor,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _showSuggestionPopup(
                                          context: context,
                                          taskId: widget.taskId);
                                    },
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        SvgPicture.asset(
                                            AppAssets.suggestionIcon,
                                            width: 18.w),
                                        SizedBox(width: 7.w),
                                        const Text(
                                          AppStrings.suggestion,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                            FontFamilies.alexandria,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  SizedBox(
                                    height: 40.h,
                                    child: const VerticalDivider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      _showComplainPopup(
                                          taskId: widget.taskId,
                                          context: context);
                                    },
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: [
                                        SvgPicture.asset(
                                            AppAssets.complainIcon,
                                            width: 18.w),
                                        SizedBox(width: 7.w),
                                        const Text(
                                          AppStrings.complain,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                            FontFamilies.alexandria,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        VerticalSpace(50.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: state == CubitBaseState.loading
                ? Center(child: CircularProgressIndicator.adaptive())
                : Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w, vertical: 20.h),
              child: joinCampaignCubit.checkedOut
                  ? Container(
                width: double.infinity,
                height: 63.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Center(
                  child: Text(
                    AppStrings.checkedOut,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamilies.alexandria,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              )
                  : joinCampaignCubit.checkedIn
                  ? NewsButton4(
                onTap: () {
                  if (joinCampaignCubit
                      .imagesUploadedToServer) {
                    // joinCampaignCubit.campaignCheckOut(
                    //     campaignId:
                    //     widget.campaignDetails!.id!,
                    //     context: context);
                    joinCampaignCubit.campaignCheckOut(
                        campaignId:
                        widget.campaignDetails!.id!,
                        context: context);
                  } else {
                    CustomSnackBars.showInfoSnackBar(
                      title: 'قم برفع الصور أولا',
                    );
                  }
                },
                text: AppStrings.checkOut,
                color: AppColors.redColor,
              )
                  : NewsButton4(
                onTap: () {
                  joinCampaignCubit.campaignCheckIn(
                    campaignId: widget.campaignDetails!.id!,
                    context: context,
                  );
                },
                text: AppStrings.checkIn,
              ),
            ),
          ),
        );
      },
    );
  }

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
                        alignment: AlignmentDirectional.topStart,
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
                                fontSize: 11.sp),
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
                            campaignId: widget.campaignDetails?.id,
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
            insetPadding: EdgeInsets.all(26.r),
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
                        alignment: AlignmentDirectional.topStart,
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
                          campaignId: widget.campaignDetails?.id,
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
