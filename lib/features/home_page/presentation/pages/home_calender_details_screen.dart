import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';

import '../../../../core/utils/app-color.dart';

class HomeCalenderDetailsScreen extends StatefulWidget {
  final Calender? calender;
  const HomeCalenderDetailsScreen({super.key, required this.calender});

  @override
  State<HomeCalenderDetailsScreen> createState() =>
      _HomeCalenderDetailsScreenState();
}

class _HomeCalenderDetailsScreenState extends State<HomeCalenderDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 330.h,
              child: Stack(
                children: [

                  PageView.builder(
                    reverse: true,
                    controller: _pageController,
                    itemCount:
                        3, // Adjust the number of items based on your ListView
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        'assets/images/palestineImg.png',
                        fit: BoxFit.fill,
                        width: double.infinity,
                      );
                    },
                  ),
                  Positioned(
                    top: 27,
                    right: 22,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white.withOpacity(0.5),
                        child: Icon(Icons.arrow_back_ios_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: DotsIndicator(
                dotsCount: 3,
                position: _currentPage,
                decorator: DotsDecorator(
                  color: Color(0xffE9791E),
                  activeColor: Color(0xffE9791E),
                  size: const Size.square(6.0),
                  activeSize: Size(39.0.w, 6),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  spacing: const EdgeInsets.all(1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'قافلة إغاثة فلسطين',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Alexandria'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Color(0xff0E395E).withOpacity(0.2)),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg/calender4.svg'),
                        SizedBox(width: 5),
                        Text(
                          '22-10-2023',
                          style:
                          TextStyle(fontFamily: 'Alexandria', fontSize: 10),
                        )
                      ],
                    ),
                  ),

                  SizedBox(width: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Color(0xff00E76B).withOpacity(0.2)),
                    child: Text(
                      'كاتيجوري الحملة',
                      style: TextStyle(fontFamily: 'Alexandria', fontSize: 10),
                    ),
                  ),

                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            //   child: Text(
            //     'حمله اغاثه فلسطين  حمله اغاثه فلسطين  حمله اغاثه فلسطين  حمله اغاثه فلسطين  حمله اغاثه فلسطين  حمله اغاثه فلسطين  حمله اغاثه فلسطين  حمله اغاثه فلسطين  حمله اغاثه فلسطين  ',
            //     style: TextStyle(
            //         fontSize: 10,
            //         fontFamily: 'Alexandria',
            //         fontWeight: FontWeight.w400),
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromHeight(60.h),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: AppColors.orangeBorderColor,
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'مشاهدة الحملة',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Alexandria',
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 5),
              SvgPicture.asset('assets/svg/myEye.svg')
            ],
          ),
        ),
      ),
    );
  }
}
