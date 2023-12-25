import 'dart:async';
import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
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
    Timer(const Duration(seconds: 2), () {
        CustomSnackBars.showSuccessToast(title: AppStrings.volunteerJoinedSuccessfully,);
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
                child: Text(AppStrings.thanksForJoiningUs,
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
