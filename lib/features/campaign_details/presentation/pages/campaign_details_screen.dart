import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../home_page/presentation/widgets/news_button.dart';
import '../widgets/button.dart';
import 'choose_role_page.dart';
import 'member_campaign_details.dart';

class CampaignDetailsScreen extends StatefulWidget {
  CampaignDetailsScreen({super.key, this.campaignDetails, this.tasks});
  final Campains? campaignDetails;
  final Tasks? tasks;
  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(double.infinity, 50.h),
                child: CustomAppBar('${widget.campaignDetails?.name}')),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Image.network(
                        widget.campaignDetails!.photo!,
                        fit: BoxFit.fill,
                      )),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            widget.campaignDetails!.name!,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: FontFamilies.alexandria,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        date,
                        SizedBox(height: 15.h),
                        campaignContent,
                        SizedBox(height: 50.h),
                        campaignMissionsText,
                        SizedBox(height: 20.h),
                        Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: widget.campaignDetails!.tasks!.map((e) {
                              return e.details?.isNotEmpty==false?Directionality(
                                textDirection: TextDirection.rtl,
                                child: ExpansionTile(
                                  initiallyExpanded: false,
                                  title: Text(
                                    '${e.task?.name}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: 'Alexandria'),
                                  ),
                                  children: e.details!.map((value) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Row(
                                        children: [
                                          CheckboxMenuButton(
                                              value: true,
                                              onChanged: (val) {},
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  fontFamily: 'Alexandria',
                                                  fontSize: 10,
                                                ),
                                              ))
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  expandedAlignment: Alignment.centerRight,
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.center,
                                ),
                              ):SizedBox.shrink();
                            }).toList()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: PreferencesHelper.getIsVisitor?SizedBox.shrink():Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: widget.campaignDetails?.userJoined == 'false'
                    ? NewsButton2(
                        onTap: () {
                          showJoinCampaignPopUp(
                              context: context,
                              campaignDetails: widget.campaignDetails);
                        },
                        text: AppStrings.joinCampaign)
                    : widget.campaignDetails?.userJoined == 'pending'
                        ? PendingButton(
                            onTap: () {}, text: AppStrings.pendingText)
                        : widget.campaignDetails?.userJoined == 'true'
                            ? NewsButton3(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            JoinCampaignDetails(
                                                taskId: 0,
                                                campaignDetails:
                                                    widget.campaignDetails)),
                                  );
                                },
                                text: 'مشاهدة الحملة')
                            : SizedBox.shrink())));
  }

  get date => Row(
        textDirection: TextDirection.rtl,
        children: [
          SvgPicture.asset(AppAssets.calendarIcon, width: 14),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '${widget.campaignDetails?.startAt}'.split(' ').first,
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: FontFamilies.alexandria,
                  fontWeight: FontWeight.w400,
                  fontSize: 10),
            ),
          ),
        ],
      );

  get campaignContent => Text(
        "${widget.campaignDetails?.details}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 11,
          fontFamily: FontFamilies.alexandria,
          height: 1.8.h,
        ),
        textAlign: TextAlign.start,
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
}

void showJoinCampaignPopUp(
    {required BuildContext context, required Campains? campaignDetails}) {
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
          content: ChooseRolePage(campaignDetails: campaignDetails));
    },
  );
}
