import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        SizedBox(width: 11.w),
        Align(
          alignment: AlignmentDirectional.topEnd,
          child: Padding(
            padding: EdgeInsets.only(top: 19.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)),
                  child: PreferencesHelper.getUserModel?.user?.photo == null
                      ? SvgPicture.asset(
                    AppAssets.circleAvatar2,
                    fit: BoxFit.fill,
                    width: 70,
                    height: 70,
                  )
                      : Image.network(
                      width: 70,
                      height: 70,
                      fit: BoxFit.fill,
                      PreferencesHelper.getUserModel!.user!.photo!)),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(left: 114.w, top: 20.h),
              child: Text(
                PreferencesHelper.getIsVisitor
                    ? 'زائر'
                    : '${PreferencesHelper.getName}',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamilies.alexandria,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
            SizedBox(height: 20.h),
            LinearPercentIndicator(
              width: 190,
              backgroundColor: const Color(0xffF1F1F1),
              progressColor: const Color(0xffF7936F),
              percent: 0,
              isRTL: true,
              lineHeight: 8,
              padding: EdgeInsets.zero,
              barRadius: const Radius.circular(5),
            ),
          ],
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}
