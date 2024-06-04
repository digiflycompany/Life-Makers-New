import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/home_page/presentation/pages/news_details.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/info_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/news_text.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:page_transition/page_transition.dart';

class NewsSample extends StatelessWidget {
  final Campaigns? campaigns;

  const NewsSample({
    Key? key,
    required this.campaigns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400),
            child: NewsDetails(campaigns: campaigns),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 4.w, right: 4.w),
        width: double.infinity,
        height: 71.h,
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (campaigns != null) NewsText(text: campaigns!.name!),
            SizedBox(
              width: 5.w,
            ),
            const HomeInfoIcon(),
          ],
        ),
      ),
    );
  }
}
