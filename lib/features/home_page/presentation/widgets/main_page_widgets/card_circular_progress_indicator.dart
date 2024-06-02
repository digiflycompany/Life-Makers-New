import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardCircularProgressIndicator extends StatelessWidget {
  const CardCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      child: Transform.scale(
        scale: 0.6,
        child: CircularProgressIndicator.adaptive(
        ),
      ),
    );
  }
}
