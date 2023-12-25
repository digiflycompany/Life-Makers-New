import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
 import 'package:page_transition/page_transition.dart';

import '../../../core/utils/app-assets.dart';
import '../../../core/utils/app-color.dart';
import 'membership_second_step.dart';



class MemberShipFirstStep extends StatefulWidget {
  const MemberShipFirstStep({Key? key}) : super(key: key);

  @override
  State<MemberShipFirstStep> createState() => _MemberShipFirstStepState();
}

class _MemberShipFirstStepState extends State<MemberShipFirstStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 300),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppAssets.unionGreyImg,
                width: double.infinity, fit: BoxFit.fill),
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 10),
              child: Text('ظبط العضوية',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Alexandria')),
            ),
            Positioned(
              top: 43,
              right: 11,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child:  Container(
                    width: 40.w,
                    height: 40.h,
                    child: Transform.scale(
                        scale: 0.45,
                        child: SvgPicture.asset(AppAssets.popUpIcon,))),
              ),
            ),

          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
              color: const Color(0xffFBC472),
            ),
            child: Image.asset(
              'assets/images/membership.png',
              fit: BoxFit.cover,
              height: 160,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 60,
              bottom: 26,
              left: 25,
              right: 25,
            ),
            child: Text(
              'قم بارفاق صورة شخصية لطلب كارنية العضوية',
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: DottedBorder(
              radius: const Radius.circular(5),
              borderType: BorderType.RRect,
              child: SizedBox(
                width: double.infinity,
                height: 84,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ارفق صورة شخصية',
                      style: TextStyle(
                        color: Color(0xff8E8E8E),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Alexandria',
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(width: 15),
                    SvgPicture.asset('assets/svg/upload.svg'),
                  ],
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 24, left: 25, right: 25),
              child: Text(
                ' (PNG - JPG بصيغة) صيغة الصورة لا تزيد عن 2 ميجابايت',
                style: TextStyle(
                  color: Color(0xffBDBDBD),
                  fontFamily: 'Alexandria',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
        child: ElevatedButton(
          
          style: ElevatedButton.styleFrom(
            
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            backgroundColor: AppColors.orangeBorderColor,
            minimumSize: const Size(double.infinity, 55),
            
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 500),
                child: const MemberShipSecondStep(),
              ),
            );
          },
          
          child: const Text(
            'إرسال',
            style: TextStyle(
              fontFamily: 'Alexandria',
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}
