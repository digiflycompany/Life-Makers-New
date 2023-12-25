import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';
import '../../../home_page/presentation/widgets/news_button.dart';
import '../../../seasonal_campaigns/model/seasonal_campaigns_model.dart';
import '../widgets/button.dart';
import 'choose_role_page.dart';

class CampaignDetailsScreen extends StatefulWidget {
  CampaignDetailsScreen({super.key, this.campaignDetails});
  final Campains? campaignDetails;

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
              campaignImg,
              SizedBox(height: 17.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    SizedBox(height: 31.h),
                    // campaignButton,
                    SizedBox(height: 19.h),
                    campaignMissionsText,
                    SizedBox(height: 20.h),
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: widget.campaignDetails!.tasks!.map((e) {
                          return Directionality(
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
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
                          );
                        }).toList()),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: (!PreferencesHelper.getIsVisitor)?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: NewsButton2(
              onTap: () {
                showJoinCampaignPopUp(
                    context: context, campaignDetails: widget.campaignDetails);
              },
              text: AppStrings.joinCampaign),
        ):SizedBox.shrink(),
      ),
    );
  }

  get header => Row(
        children: [
          SizedBox(
            width: 140.w,
          ),
          TitleText(text: widget.campaignDetails?.name),
          SizedBox(width: 105.w),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              AppAssets.popUpIcon,
            ),
          ),
        ],
      );
  get campaignImg => AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        widget.campaignDetails!.photo!,
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
          '${widget.campaignDetails?.startAt}',
          style: TextStyle(
              color: Colors.grey,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w400,
              fontSize: 8),
        ),
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
}
