import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import '../../../../core/utils/app-assets.dart';
import '../../cubit/volunteer_thanks_cubit.dart';

class VolunteerThanksScreen extends StatefulWidget {
  const VolunteerThanksScreen({super.key});

  @override
  State<VolunteerThanksScreen> createState() => _VolunteerThanksScreenState();
}

class _VolunteerThanksScreenState extends State<VolunteerThanksScreen> {
  late VolunteerThanksCubit volunteerThanksCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
        Navigator.pop(context);
    });

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: Image.asset(AppAssets.thanksImg)),
            Padding(
              padding: EdgeInsets.only(top: 240.h, left: 20.w),
              child: Center(
                child: Text('شكرا لطلب انضمامك الينا جاري مراجعة طلبك',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: FontFamilies.alexandria
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
