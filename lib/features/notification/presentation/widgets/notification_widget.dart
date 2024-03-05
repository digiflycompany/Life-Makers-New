import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
           color:Colors.grey.shade300,
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
      backgroundImage: AssetImage(img!),
      radius: 30.r,
      //child: SvgPicture.asset(img!),
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
    padding:  EdgeInsets.only(left: 10.w),
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
        textAlign: TextAlign.center,
      ),
    ),
  );
}
