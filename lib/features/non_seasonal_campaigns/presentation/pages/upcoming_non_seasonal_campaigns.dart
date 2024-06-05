import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:life_makers/features/seasonal_campaigns/presentation/widgets/campaigns_details_widget.dart';

import '../../../../core/utils/app-string.dart';

class UpcomingNonSeasonalCampaignsScreen extends StatelessWidget {
   final List<Campaigns>? campaigns;

   UpcomingNonSeasonalCampaignsScreen({this.campaigns});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: buildGridView(),
        ),
    );
  }
   Widget buildGridView() {
     return Directionality(
       textDirection: TextDirection.rtl,
       child:campaigns?.isNotEmpty==true? GridView.builder(
         physics: const BouncingScrollPhysics(),
         shrinkWrap: true,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2,
           childAspectRatio: (1 / .84),
           crossAxisSpacing:
           18.h, // Adjust the spacing between items horizontally
           mainAxisSpacing: 18.w, // Adjust the spacing between items vertically
         ),
         itemCount: campaigns?.length, // Number of items in the grid
         itemBuilder: (context, index) {
           // Replace the following with your actual components/widgets
           return CampaignDetailsWidget(
             context: context,
               campaignDetails: campaigns?[index],
               color: AppColors.greenColor3,
               borderColor:
               AppColors.greenColor
           );
         },
       ):buildEmptySeasonWidget(),
     );
   }

}
Widget buildEmptySeasonWidget(){
  return Center(
    child: Padding(
      padding:  EdgeInsets.only(bottom: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.noCampaignsImg),
          SizedBox(height: 30.h,),
          const Text(
            AppStrings.noCampaignsText,
            style: TextStyle(
                color:AppColors.greyColor4,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w500,
                fontSize: 13
            ),
          )
        ],
      ),
    ),
  );
}