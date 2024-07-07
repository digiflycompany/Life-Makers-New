import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CampaignDescriptionText extends StatelessWidget {
  final String desc;

  const CampaignDescriptionText({
    Key? key,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.only(right: 0),
        child: Container(
          height: 20.h,
          child: Wrap(
            children: [
            Text(
              desc,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Alexandria', // Assuming FontFamilies.alexandria is a string 'Alexandria'
                fontWeight: FontWeight.w400,
                fontSize: 10,
                height: 1.56,
              ),
              textDirection: TextDirection.rtl,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          ),
        ),
      ),
    );
  }
}
