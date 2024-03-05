import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/utils/app-assets.dart';
import '../../features/home_page/presentation/pages/drawer_page.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity, 100),
           child: Stack(
        alignment: Alignment.center,
        children: [
          InkWell(
            onTap: () {

              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 100),
                  child:  DrawerPage()),
                      (vale)=>true);

            },
            child: Image.asset(AppAssets.unionGreyImg,
                width: double.infinity, fit: BoxFit.fill),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 0, bottom: 10),
            child: Text('الذهاب إلي الرئيسية',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Alexandria')),
          ),
          Positioned(
            top: 42,
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

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 90,),
            Image.asset('assets/images/thanks.png'),
            const Text('تم الدفع بنجاح وسوف يتم التواصل معك لاستلام الكارنيه ',style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
              fontFamily: 'Alexandria'
            ),)
          ],
        ),
      ),
    );
  }
}
