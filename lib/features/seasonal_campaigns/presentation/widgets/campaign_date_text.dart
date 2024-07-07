import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';

class CampaignDateText extends StatelessWidget {
  final String date;

  const CampaignDateText({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppAssets.calendarIcon,
          width: 12.w,

        ),
        Padding(
          padding: EdgeInsets.only(right: 5, left: 30),
          child: Text(
            date,
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'Alexandria', // Assuming FontFamilies.alexandria is a string 'Alexandria'
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
