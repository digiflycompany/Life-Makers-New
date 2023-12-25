import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/home_page/presentation/widgets/news_button.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../seasonal_campaigns/model/seasonal_campaigns_model.dart';

class NewsDetails extends StatelessWidget {
  NewsDetails({super.key, this.campains});
  final Campains? campains;
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
      bottomNavigationBar: getButton(context),
    );
  }

  get campaignImage => AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        campains!.photo!,
        fit: BoxFit.cover,
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
            height: 10.h,
          ),
        ],
      );

  get title => Padding(
        padding: EdgeInsets.only(left: 38.w),
        child: Text(
          '${campains?.name}',
          style: TextStyle(
              color: Colors.black,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              height: 2.h),
          textDirection: TextDirection.rtl,
          maxLines: 2,
        ),
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

  getButton(BuildContext context) => NewsButton(
      onTap: () {
        // _showPopup(context);
      },
      text: AppStrings.joinCampaign);

  getbody(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        child: Column(
          children: [
            title,
            SizedBox(
              height: 22.h,
            ),
            detailsText1,
            SizedBox(
              height: 141.h,
            ),
            SizedBox(
              height: 25.h,
            ),
          ],
        ),
      );
}
