import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/presentation/pages/previous_seasonal_campaigns.dart';
import 'package:life_makers/features/non_seasonal_campaigns/presentation/pages/upcoming_non_seasonal_campaigns.dart';
import '../model/seasonal_campaigns_model.dart';

Widget buildCampaignGridView(
    {List<Campains>? campaigns, required BuildContext context}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: campaigns?.isNotEmpty == true
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GridView.builder(
              padding: EdgeInsets.only(bottom: 100),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 18.h,
                mainAxisSpacing: 18.w,
              ),
              itemCount: campaigns?.length,
              itemBuilder: (context, index) {
                return CampaignDetailsWidget(
                    campaignDetails: campaigns?[index],
                    color: AppColors.greenBackgroundColor,
                    context: context,
                    borderColor: AppColors.greenBorderColor);
              },
            ),
          )
        : buildEmptySeasonWidget(),
  );
}

Widget buildAllCampaignGridView(
    {List<Campains>? campaigns, required BuildContext context}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: campaigns?.isNotEmpty == true
        ? GridView.builder(
            physics:  const BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (1 / .9),
              crossAxisSpacing: 18.h,
              mainAxisSpacing: 18.w,
            ),
            itemCount: campaigns?.length,
            itemBuilder: (context, index) {
              return CampaignDetailsWidget(
                  campaignDetails: campaigns?[index],
                  color: AppColors.greenBackgroundColor,
                  context: context,
                  borderColor: AppColors.greenBorderColor);
            },
          )
        : buildEmptySeasonWidget(),
  );
}
