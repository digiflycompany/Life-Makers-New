import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/home_page/presentation/widgets/news_button.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../../../campaign_details/presentation/pages/campaign_details_screen.dart';

class NewsDetails extends StatelessWidget {
  NewsDetails({super.key, this.campains});
  final Campaigns? campains;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              getheader(context),
              SizedBox(height: 20.h),
              getbody(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20,right: 20,left: 20),

          child:getButton(context)),
    );
  }

  get campaignImage => AspectRatio(
      aspectRatio: 16 / 10,
      child: Image.network(
        campains!.photo!,
        fit: BoxFit.fill,
      ));

  greyCircle(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: EdgeInsets.only(top: 17.h, right: 13.w),
              child: SvgPicture.asset(AppAssets.newsPopUp),
            )),
      );

  newsArrow(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: EdgeInsets.only(top: 27.h, right: 23.w),
              child: SvgPicture.asset(AppAssets.newsArrow),
            )),
      );

  getheader(BuildContext context) => Stack(
        children: [
          campaignImage,
          greyCircle(context),
          newsArrow(context),
          SizedBox(
            height: 10.h
          ),
        ],
      );

  get title => Text(
    '${campains?.name}',
    style: TextStyle(
        color: Colors.black,
        fontFamily: FontFamilies.alexandria,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        ),
    textDirection: TextDirection.rtl,
    maxLines: 2,
  );

  get detailsText1 => Text(
        '${campains?.details}',
        style: TextStyle(
            color: Colors.black,
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w400,
            fontSize: 11,
            height: 2.h),
        textDirection: TextDirection.rtl,
      );

  getButton(BuildContext context) {
    if(campains?.userJoined=='false')
    return NewsButton2(
      onTap: () {
        showJoinCampaignPopUp(
            context: context,
            campaignDetails: campains);
      },
      text: AppStrings.joinCampaign);
    else return PendingButton(onTap: (){
      CustomSnackBars.showInfoSnackBar(title: AppStrings.pendingText);

    }, text: AppStrings.pendingText);
  }

  getbody(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        child: Column(
          children: [
            title,
            SizedBox(height: 22.h),
            detailsText1,
          ],
        ),
      );
}

