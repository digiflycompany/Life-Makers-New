import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/widgets/custom_appbar.dart';
import 'package:life_makers/features/home_page/presentation/widgets/news_button.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_content.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_date.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_image.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_name.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'choose_role_page.dart';
import 'member_campaign_details.dart';

class CampaignDetailsScreen extends StatefulWidget {
  CampaignDetailsScreen({super.key, this.campaignDetails, this.tasks});
  final Campaigns? campaignDetails;
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
          child: CustomAppBar('${widget.campaignDetails?.name}'),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CampaignImage(campaignDetails: widget.campaignDetails),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CampaignName(campaignDetails: widget.campaignDetails),
                    CampaignDate(campaignDetails: widget.campaignDetails),
                    CampaignContent(campaignDetails: widget.campaignDetails),
                    // const CampaignMissionText(),
                    // CampaignTasks(campaignDetails: widget.campaignDetails),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: PreferencesHelper.getIsVisitor
            ? SizedBox.shrink()
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                    builder: (context) => JoinCampaignDetails(
                      taskId: 0,
                      campaignDetails: widget.campaignDetails,
                    ),
                  ),
                );
              },
              text: 'مشاهدة الحملة')
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}

void showJoinCampaignPopUp(
    {required BuildContext context, required Campaigns? campaignDetails}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7.r)),
        ),
        insetPadding: EdgeInsets.all(26.r),
        scrollable: true,
        titlePadding: const EdgeInsets.all(0),
        contentPadding: EdgeInsets.zero,
        content: ChooseRolePage(campaignDetails: campaignDetails),
      );
    },
  );
}
