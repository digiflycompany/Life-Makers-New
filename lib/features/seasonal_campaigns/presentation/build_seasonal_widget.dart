import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/non_seasonal_campaigns/presentation/pages/upcoming_non_seasonal_campaigns.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaigns_details_widget.dart';

Widget buildCampaignGridView(
    {List<Campaigns>? campaigns, required BuildContext context}) {
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
                    color: AppColors.greenColor3,
                    context: context,
                    borderColor: AppColors.greenColor);
              },
            ),
          )
        : buildEmptySeasonWidget(),
  );
}
