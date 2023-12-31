import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app_fonts.dart';

class NotificationWidget extends StatelessWidget {
  final String? img;
  final String? description;
  final String? time;
  const NotificationWidget({super.key,required this.img, required this.description, required this.time});

  @override
  Widget build(BuildContext context) {
     return Padding(
       padding:  EdgeInsets.only(right: 20.w,left: 20.w),
       child: Container(
         height: 88.h,
         decoration: BoxDecoration(
           color: AppColors.greyTabColor,
           borderRadius: BorderRadius.circular(8.r),
         ),
         child: Row(
           textDirection: TextDirection.rtl,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             image,
             descriptionText,
             timeText,
           ],
         ),
       ),
     );
  }
  get image => Padding(
    padding:  EdgeInsets.only(right: 8.w),
    child: CircleAvatar(
      radius: 30.r,
      backgroundImage: AssetImage(img!),
    ),
  );
  get descriptionText => Text(description!,
    style: TextStyle(
        color: Colors.black,
        fontFamily: FontFamilies.alexandria,
        fontWeight: FontWeight.w600,
        fontSize: 12.5,
        height: 2.h
    ),
    textDirection: TextDirection.rtl,
  );
  get timeText => Padding(
    padding:  EdgeInsets.only(left: 5.w),
    child:  SizedBox(
      width: 70,
      child: Text(time!,
        style:  TextStyle(
          color: Colors.grey.shade600,
          fontFamily: FontFamilies.alexandria,
          fontWeight: FontWeight.w600,
          fontSize: 8,
        ),
        textDirection: TextDirection.rtl,
      ),
    ),
  );
}
