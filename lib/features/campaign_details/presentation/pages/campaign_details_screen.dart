import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/widgets/custom_appbar.dart';
import 'package:life_makers/features/home_page/presentation/widgets/news_button.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_cubit.dart';
import 'package:life_makers/features/seasonal_campaigns/cubit/seasonal_campaigns_states.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_content.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_date.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_image.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaign_details_widgets/campaign_name.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'choose_role_page.dart';
import 'member_campaign_details.dart';

class CampaignDetailsScreen extends StatefulWidget {
  CampaignDetailsScreen({super.key, this.campaignDetails, this.tasks,});
  final Campaigns? campaignDetails;
  final Tasks? tasks;

  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<SeasonalCampaignsCubit>();
    cubit.getSeasonalCampaignsRepo(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SeasonalCampaignsCubit>(
      create: (BuildContext context) => SeasonalCampaignsCubit()..getSeasonalCampaignsRepo(context: context),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 50.h),
            child: CustomAppBar('${widget.campaignDetails?.name}'),
          ),
          body: BlocBuilder<SeasonalCampaignsCubit, SeasonalCampaignsStates>(
            builder: (context, state) {
              if (state is SeasonalCampaignsLoadingStates) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SeasonalCampaignsSuccessStates) {
                final campaignDetails = state.campaigns.firstWhere((campaign) => campaign.id == widget.campaignDetails?.id);
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      CampaignImage(campaignDetails: campaignDetails),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CampaignName(campaignDetails: campaignDetails),
                            CampaignDate(campaignDetails: campaignDetails),
                            CampaignContent(campaignDetails: campaignDetails),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is SeasonalCampaignsErrorStates) {
                return Center(child: Text(''));
              } else {
                return Center(child: Text('Error loading campaign details'));
              }
            },
          ),
          bottomNavigationBar: PreferencesHelper.getIsVisitor
              ? SizedBox.shrink()
              : BlocBuilder<SeasonalCampaignsCubit, SeasonalCampaignsStates>(
            builder: (context, state) {
              if (state is SeasonalCampaignsSuccessStates) {
                final campaignDetails = state.campaigns.firstWhere((campaign) => campaign.id == widget.campaignDetails?.id);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: campaignDetails.userJoined == 'false'
                      ? NewsButton2(
                      onTap: () {
                        showJoinCampaignPopUp(
                            context: context,
                            campaignDetails: campaignDetails);
                      },
                      text: AppStrings.joinCampaign)
                      : campaignDetails.userJoined == 'pending'
                      ? PendingButton(
                      onTap: () {}, text: AppStrings.pendingText)
                      : campaignDetails.userJoined == 'true'
                      ? NewsButton3(
                      onTap: () {
                        if (campaignDetails.tasks != null && campaignDetails.tasks!.isNotEmpty) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JoinCampaignDetails(
                                taskId: campaignDetails.tasks!.first.id!,
                                campaignDetails: campaignDetails,
                              ),
                            ),
                          );
                        } else {
                          // Handle the case where there are no tasks or task ID is null
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No tasks available for this campaign')),
                          );
                        }
                      },
                      text: 'مشاهدة الحملة')
                      : SizedBox.shrink(),
                );
              }
              return SizedBox.shrink();
            },
          ),
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
