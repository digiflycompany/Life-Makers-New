import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app_fonts.dart';

import '../../../../core/utils/app-color.dart';
import '../../models/all_candidates_model.dart';

class ElectionsCard extends StatefulWidget {
  final Voters? voter;
 final Function ? function;
  final int  length;
    ElectionsCard({super.key, required this.voter,required this.function,required this.length});

  @override
  State<ElectionsCard> createState() => _ElectionsCardState();
}

class _ElectionsCardState extends State<ElectionsCard> {

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: selected == false
            ? AppColors.blueColor4
            : AppColors.orangeColor,
      ),
      child: InkWell(
        onTap: () {
          if (kDebugMode) {
            print(widget.length);
          }
          if(widget.length<5)
            {
              widget.function!();
              selected = !selected;
              setState(() {});
            }
        },
        child: Stack(
          children: [
            Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Image.asset(AppAssets.electionsCardBackgroundImage),
                )),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 7.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r)),
                    child: Image.network(
                      '${widget.voter?.imageUrl}',
                      height: 100.h,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: 10.w, bottom: 6.h, left: 10.w),
                    child: Text(
                      '${widget.voter?.details}',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontFamilies.alexandria,
                        fontWeight: FontWeight.w400,
                        fontSize: 8.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Text(
                      '${widget.voter?.name}',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontFamilies.alexandria,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
