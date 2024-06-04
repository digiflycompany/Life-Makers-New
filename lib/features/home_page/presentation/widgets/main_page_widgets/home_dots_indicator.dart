import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomeDotsIndicator extends StatelessWidget {
  final int length;
  final int currentPage;

  const HomeDotsIndicator({
    Key? key,
    required this.length,
    this.currentPage=0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DotsIndicator(
        dotsCount: length,
        position: currentPage,
        decorator: DotsDecorator(
          color: Colors.red.shade300,
          activeColor: Colors.red.shade300,
          size: const Size.square(6.0),
          activeSize: Size(39.0.w, 6),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          spacing: const EdgeInsets.all(1),
        ),
      ),
    );
  }
}
